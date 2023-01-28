import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:handees/res/uri.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  static PaymentRepository? _instance = PaymentRepository._();
  PaymentRepository._();

  factory PaymentRepository() {
    _instance ??= PaymentRepository();
    return _instance!;
  }

  Future<String> getAccessCode({
    required String email,
    required int amount,
  }) async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    final response = await http.post(
      AppUris.paymentsUri,
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
  }
}
