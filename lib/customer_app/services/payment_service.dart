import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:handees/res/constants.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authServiceProvider = Provider<AuthService>((ref) => AuthService._());

class PaymentService {
  PaymentService._();
  static final PaymentService _instance = PaymentService._();
  static PaymentService get instance => _instance;

  final firebaseAuth = FirebaseAuth.instance;

  Future<String> accessCodeRequest({
    required String email,
    required int amount,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    try {
      final response = await http.post(
        Uri.https(
          AppConstants.url,
          '/payments/',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'access-token': token,
        },
        body: jsonEncode(
          {
            'email': email,
            'amount': amount,
          },
        ),
      );

      debugPrint('AccessCode request response: ${response.body}');

      return jsonDecode(response.body)['data']['access_code'];
    } on Exception {
      // TODO
      rethrow;
    }
  }
}
