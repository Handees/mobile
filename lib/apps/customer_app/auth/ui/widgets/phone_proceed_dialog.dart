import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

class PhoneProceedDialog extends StatelessWidget {
  const PhoneProceedDialog({
    Key? key,
    required this.onProceed,
  }) : super(key: key);

  final void Function() onProceed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: const ShapeDecoration(
              shape: Shapes.mediumShape,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 24),
          const Text('You’ll receive a 4 digit code to verify'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onProceed,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
