import 'package:handees/shared/data/payments/payment_repository.dart';
import 'package:handees/shared/data/user/user_repository.dart';

class PaymentService {
  PaymentService._(this.paymentRepository, this.userRepository);

  static final instance =
      PaymentService._(PaymentRepository(), UserRepository());

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
