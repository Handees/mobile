import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService._());

class AuthService {
  AuthService._();

  late String _verificationId;
  final firebaseAuth = FirebaseAuth.instance;

  bool isAuthenticated() =>
      firebaseAuth.currentUser != null &&
      firebaseAuth.currentUser!.email!.isNotEmpty;

  Future<bool> emailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await firebaseAuth.fetchSignInMethodsForEmail(emailAddress);
      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return true;
    }
  }

  Future<AuthResponse> signinUser(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // TODO: sign in with phone
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

  Future<AuthResponse> completeProfile(
    String email,
    String password,
    String name,
  ) async {
    final user = firebaseAuth.currentUser!;

    try {
      await user.updatePassword(password);
      await user.updateEmail(email);
      await user.updateDisplayName(name);

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

  Future<AuthResponse> verifyNumber(
      String smsCode, String verificationId) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    print('Verifying with smscode $smsCode and id $verificationId');
    try {
      final credential =
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

  void signupWithPhone({
    required String phone,
    required void Function(String verificationId, int? forceResendingToken)
        onCodeSent,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        onVerifcationComplete,
    required void Function(FirebaseAuthException error) onVerificationFailed,
  }) {
    // await credential.user?.updateDisplayName(name);

    FirebaseAuth.instance.verifyPhoneNumber(
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
