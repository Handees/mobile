import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/services/payment_service.dart';
import 'package:handees/utils/utils.dart';

final addCardProvider =
    StateNotifierProvider<AddCardStateNotifier, bool>((ref) {
  // final authService = ref.watch(authServiceProvider);
  return AddCardStateNotifier(
      ref.watch(paymentServiceProvider), ref.watch(authServiceProvider));
});

class AddCardStateNotifier extends StateNotifier<bool>
    with InputValidationMixin {
  AddCardStateNotifier(this._paymentService, this._authService) : super(true);

  final PaymentService _paymentService;
  final AuthService _authService;

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
