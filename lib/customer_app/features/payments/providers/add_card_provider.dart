import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/utils/utils.dart';
import 'package:http/http.dart' as http;

final addCardProvider =
    StateNotifierProvider<AddCardStateNotifier, bool>((ref) {
  // final authService = ref.watch(authServiceProvider);
  return AddCardStateNotifier();
});

class AddCardStateNotifier extends StateNotifier<bool>
    with InputValidationMixin {
  AddCardStateNotifier() : super(true);

  late String _cardNumber;
  late String _cvv;
  late int _month;
  late int _year;

  void onCardNumberSaved(String? cardNumber) => _cardNumber = cardNumber!;
  void onSecurityCodeSaved(String? cvv) => _cvv = cvv!;
  void onExpiryDateSaved(String? name) {
    _month = int.parse(name?.substring(0, 2) ?? "0");
    _year = int.parse(name?.substring(name.length - 2, name.length) ?? "0");
  }

  String testCheck() => '$_cardNumber, $_cvv, $_month/$_year';

  PaymentCard _getCard() => PaymentCard(
      number: _cardNumber, cvc: _cvv, expiryMonth: _month, expiryYear: _year);

  Future<Charge> test() async {
    final accessCode = await _accessCodeRequest();

    if (_getCard().isValid()) {
      print(_getCard().isValid());

      return Charge()
        ..accessCode = accessCode
        ..card = _getCard();
    }

    throw Exception('Invalid card');
  }

  Future<String> _accessCodeRequest() async {
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();

    try {
      final response = await http.post(
        Uri.https(
          'cfm67.localtonet.com',
          '/payments/',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'access-token': token,
        },
        body: jsonEncode(
          {
            'email': 'paulasalu7@gmail.com',
            'amount': 50,
          },
        ),
      );

      print(response.body);

      return jsonDecode(response.body)['data']['access_code'];
    } on Exception catch (e) {
      // TODO
      rethrow;
    }
  }

  void resetState() {}
}
