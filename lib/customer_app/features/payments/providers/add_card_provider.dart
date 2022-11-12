import 'package:flutter/foundation.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/services/auth_service.dart';
import 'package:handees/utils/utils.dart';

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

  Charge test() {
    return Charge()
      ..accessCode = 'accessCode'
      ..card = PaymentCard(
          number: _cardNumber,
          cvc: _cvv,
          expiryMonth: _month,
          expiryYear: _year);
  }

  void resetState() {}
}
