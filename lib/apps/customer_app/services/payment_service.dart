import 'package:firebase_auth/firebase_auth.dart';
import 'package:handees/data/payments/payment_repository.dart';

class PaymentService {
  PaymentService._();
  static final PaymentService _instance = PaymentService._();
  static PaymentService get instance => _instance;

  final paymentRepository = PaymentRepository();

  final firebaseAuth = FirebaseAuth.instance;

  Future<String> accessCodeRequest({
    required String email,
    required int amount,
  }) =>
      paymentRepository.accessCodeRequest(email: email, amount: amount);
}
