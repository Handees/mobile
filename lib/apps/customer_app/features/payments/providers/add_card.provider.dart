import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/apps/customer_app/services/payment_service.customer.dart';

final addCardProvider =
    StateNotifierProvider<AddCardStateNotifier, bool>((ref) {
  return AddCardStateNotifier(PaymentService.instance, AuthService.instance);
});

class AddCardStateNotifier extends StateNotifier<bool> {
  final PaymentService _paymentService;
  final AuthService _authService;
  AddCardStateNotifier(this._paymentService, this._authService) : super(true);

  late String _cardNumber;
  late String _cvv;
  late int _month;
  late int _year;

  void onCardNumberSaved(String? cardNumber) => _cardNumber = cardNumber!;
  void onSecurityCodeSaved(String? cvv) => _cvv = cvv!;
  void onExpiryDateSaved(String? date) {
    _month = int.parse(date?.substring(0, 2) ?? "0");
    _year = int.parse(date?.substring(date.length - 2, date.length) ?? "0");
  }

  PaymentCard _getCard() => PaymentCard(
      number: _cardNumber, cvc: _cvv, expiryMonth: _month, expiryYear: _year);

  Future<Charge> getCharge() async {
    final accessCode = await _paymentService.accessCodeRequest(
      email: _authService.user.email!,
      amount: 5000,
    );

    if (_getCard().isValid()) {
      return Charge()
        ..accessCode = accessCode
        ..card = _getCard();
    }

    throw Exception('Invalid card');
  }
}
