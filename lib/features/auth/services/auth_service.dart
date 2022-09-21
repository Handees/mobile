import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService._());

class AuthService {
  AuthService._();

  Future<void> signupUser(String email, String password, String name) async {
    print('Email: $email, Password $password, Name $name');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      credential.user?.updateDisplayName(name);
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
          message = e.toString();
      }
      debugPrint(message);
    } catch (e) {
      final message = 'Auth Execption: $e';
      debugPrint(message);
    }
  }
}
