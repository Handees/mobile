import 'package:flutter/material.dart';

import 'widgets/payment_methods.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment methods'),
      ),
      body: const Column(
        children: [
          PaymentMethods(),
        ],
      ),
    );
  }
}
