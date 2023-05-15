import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

class ErrorOverlay extends StatelessWidget {
  const ErrorOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: Shapes.mediumShape,
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: const EdgeInsets.all(32.0),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 50, backgroundColor: Colors.red),
          Text('Error'),
        ],
      ),
    );
  }
}
