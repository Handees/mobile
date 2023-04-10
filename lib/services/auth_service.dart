import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/user/user_repository.dart';
import 'package:handees/res/uri.dart';
import 'package:http/http.dart' as http;

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService._(FirebaseAuth.instance, UserRepository());
});

final tokenProvider = Provider((ref) {
  return ref.watch(authServiceProvider).token;
});

class AuthService {
//TODO test should remove;
  static AuthService test =
      AuthService._(FirebaseAuth.instance, UserRepository());

  AuthService._(this.firebaseAuth, this.userRepository) {
    FirebaseAuth.instance.userChanges().listen((user) {
      user?.getIdToken().then((value) {
        _token = value;

        userRepository.updateUserData(
          name: user.displayName ?? '',
          phone: user.phoneNumber ?? '',
          email: user.email ?? '',
          uid: user.uid,
          token: _token,
        );
      });
    });
  }

  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;

  User get user => firebaseAuth.currentUser!;

  late String _token;

  String get token => _token;

  static bool isAuthenticated() => FirebaseAuth.instance.currentUser != null;
  static bool isProfileComplete() =>
      FirebaseAuth.instance.currentUser!.email != null &&
      FirebaseAuth.instance.currentUser!.email!.isNotEmpty &&
      FirebaseAuth.instance.currentUser!.displayName != null &&
      FirebaseAuth.instance.currentUser!.displayName!.isNotEmpty;

  Future<bool> dataSubmitted() async {
    // if (await userRepository.local.isDataStored) return true;
    try {
      final response = await http.get(
        AppUris.userDataUri(user.uid),
      );

      return response.statusCode != 404;
    } on Exception catch (e) {
      debugPrint('Data submit error $e');
      return false;
    }
  }

  Future<bool> emailInUse(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await firebaseAuth.fetchSignInMethodsForEmail(email);
      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email address is not in use
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return true;
    }
  }

  Future<AuthResponse> signinUser(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResponse.success;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      AuthResponse response;

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          response = AuthResponse.noSuchEmail;
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          response = AuthResponse.incorrectPassword;
          break;

        default:
          message = 'Auth Execption: $e';
          response = AuthResponse.unknownError;
      }

      debugPrint(message);
      return response;
    } catch (e) {
      final message = 'Auth Execption: $e';
      debugPrint(message);
      return AuthResponse.unknownError;
    }
  }

  ///Updates additional data on firebase authentication profile such as name,
  ///email and password
  ///
  ///Returns corresponding AuthResponse
  Future<AuthResponse> updateFirebaseProfile({
    String? email,
    String? password,
    String? name,
  }) async {
    final user = firebaseAuth.currentUser!;

    try {
      if (password != null) await user.updatePassword(password);
      if (name != null) await user.updateDisplayName(name);
      if (email != null) await user.updateEmail(email);

      return AuthResponse.success;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      AuthResponse response = AuthResponse.unknownError;

      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          response = AuthResponse.weakPassword;
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          response = AuthResponse.emailInUse;
          break;
        case 'invalid-email':
          message = 'Not a valid email';
          response = AuthResponse.invalidEmail;
          break;
        case 'requires-recent-login':
          message =
              'Requires recent login. Shouldn\'t occur as this is instantenous';
          break;

        default:
          message = e.toString();
      }

      debugPrint(message);
      return response;
    } catch (e) {
      final message = 'Auth Execption: $e';
      debugPrint(message);
      return AuthResponse.unknownError;
    }
  }

  ///Submits user data to the server
  ///
  ///Returns true if data was submitted successfully and false otherwise
  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
  }) async {
    try {
      return await userRepository.submitUserData(
        name: name,
        phone: phone,
        email: email,
        uid: uid,
        token: token,
      );
    } on Exception catch (e) {
      print('Got error $e');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<AuthResponse> verifyNumber(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      return AuthResponse.success;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      AuthResponse response;

      switch (e.code) {
        case 'account-exists-with-different-credential':
          message = 'An account already exists for that phone number';
          response = AuthResponse.phoneInUse;
          break;
        case 'invalid-verification-code':
        case 'invalid-verification-id':
          message =
              'An error occured. Please try resending the verification code';
          response = AuthResponse.invalidVerificationCode;
          break;
        case 'invalid-phone-number':
          message = 'The phone number provided is not valid';
          response = AuthResponse.invalidPhone;
          break;
        default:
          message = e.toString();
          response = AuthResponse.unknownError;
      }
      debugPrint(message);
      return response;
    } catch (e) {
      final message = 'Auth Execption: $e';
      debugPrint(message);
      return AuthResponse.unknownError;
    }
  }

  Future<void> signupWithPhone({
    required String phone,
    required void Function(String verificationId, int? forceResendingToken)
        onCodeSent,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        onVerifcationComplete,
    required void Function(FirebaseAuthException error) onVerificationFailed,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: onVerifcationComplete,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void signoutUser() => firebaseAuth.signOut();
}

enum AuthResponse {
  success,
  incorrectPassword,
  noSuchEmail,
  unknownError,
  weakPassword,
  emailInUse,
  phoneInUse,
  invalidEmail,
  invalidPhone,
  invalidVerificationCode,
}
