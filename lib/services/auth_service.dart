import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthService with ChangeNotifier {
  // factory AuthService() => instance;
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  AuthStatus _status = AuthStatus.idle;

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

  Future<String> signupUser(Map<String, String> userDetails) async {
    _status = AuthStatus.processing;
    notifyListeners();

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

      final result =
          await AuthService.instance.postUserDetails(credential!, userDetails);

      print("stat ${result.statusCode}");
      print("body ${result.body}");

      _status = AuthStatus.success;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.toString();
      }
      _status = AuthStatus.error;
      notifyListeners();
      return message;
    } catch (e) {
      final message = "Auth Execption: " + e.toString();
      print(message);
      return message;
    }

    return "AUTH_SERVICE ERROR";
  }
}

enum AuthStatus { idle, processing, success, error }
