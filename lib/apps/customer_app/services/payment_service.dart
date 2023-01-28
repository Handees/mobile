import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/payments/payment_repository.dart';
import 'package:handees/data/user/user_repository.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService._(PaymentRepository(), UserRepository());
});

class PaymentService {
  PaymentService._(this.paymentRepository, this.userRepository);

  final UserRepository userRepository;
  final PaymentRepository paymentRepository;

  Future<String> accessCodeRequest({
    required String email,
    required int amount,
  }) async {
    try {
      return await paymentRepository.getAccessCode(
          email: email, amount: amount);
    } on Exception {
      // TODO
      rethrow;
    }
  }
}
