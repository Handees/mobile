import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthService {
  // factory AuthService() => instance;
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  // AuthStatus _status = AuthStatus.idle;

  Future<Response> postUserDetails(
      UserCredential credential, Map<String, String> userDetails) {
    return post(
      Uri.parse("https://f2cc-102-89-32-175.ngrok.io/user/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(
        {
          'name': userDetails['name'],
          'user_id': credential.user?.uid,
          'email': userDetails['email'],
        },
      ),
    );
  }

  Future<String> signinUser(Map<String, String> userDetails) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userDetails['email']!,
        password: userDetails['password']!,
      ); // TODO: sign in with phone

    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;

        default:
          message = e.toString();
      }

      return message;
    } catch (e) {
      final message = 'Auth Execption: $e';
      print(message);
      return message;
    }

    return 'SUCCESS';
  }

  Future<String> signupUser(Map<String, String> userDetails) async {
    try {
      final credential = userDetails.containsKey('email')
          ? await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userDetails['email']!,
              password: userDetails['password']!,
            )
          : null;
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //     phoneNumber: _details['phone']!,
      //     verificationCompleted: (_) {},
      //     verificationFailed: (_) {},
      //     codeSent: codeSent,
      //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      //   ); //TODO: Create phone sign-in;

      // final result =
      //     await AuthService.instance.postUserDetails(credential!, userDetails);
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';

      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'phone-number-already-exists':
          message = 'An account already exists for that phone number';
          break;
        default:
          e.toString();
      }

      return message;
    } catch (e) {
      final message = 'Auth Execption: $e';
      print(message);
      return message;
    }

    return 'SUCCESS';
  }
}
