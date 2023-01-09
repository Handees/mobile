import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:handees/res/uri.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService._() {
    FirebaseAuth.instance.idTokenChanges().listen((user) {
      user?.getIdToken().then((value) => _token = value);
    });
  }

  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  // late String _verificationId;
  final firebaseAuth = FirebaseAuth.instance;

  User get user => firebaseAuth.currentUser!;

  late String _token;

  String get token => _token;
  // void updateToken(String token) => _token = token;

  bool isAuthenticated() =>
      firebaseAuth.currentUser != null &&
      firebaseAuth.currentUser!.email != null &&
      firebaseAuth.currentUser!.email!.isNotEmpty;

  Future<bool> dataSubmitted() async {
    try {
      final response = await http.get(
        AppUris.userDataUri(user.uid),
      );

      print('Check Data submit ${response.body}');
      print('Check Data submit code${response.statusCode}');
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

  Future<AuthResponse> completeProfile(
    String email,
    String password,
    String name,
  ) async {
    final user = firebaseAuth.currentUser!;

    print('Completing profile');

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

  ///Sends an HTTP POST request to submit user data
  ///
  ///Returns true if data was submitted successfully and false otherwise
  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
  }) async {
    print('Submittin user data');

    try {
      final future = http.post(
        AppUris.addNewUserUri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'access-token': token,
        },
        body: jsonEncode(
          {
            'name': name,
            // 'telephone': phone,
            'email': email,
            'user_id': uid,
          },
        ),
      );

      final response = await future;
      print("Submit user data response ${response.body}");

      print("Submit user data response code ${response.statusCode}");

      //TODO: Error handling

      if (response.statusCode > 200 && response.statusCode < 400) {
        return true;
      } else {
        return false;
        //TODO what if it fails password is still there
      }
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

  void signupWithPhone({
    required String phone,
    required void Function(String verificationId, int? forceResendingToken)
        onCodeSent,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        onVerifcationComplete,
    required void Function(FirebaseAuthException error) onVerificationFailed,
  }) {
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
