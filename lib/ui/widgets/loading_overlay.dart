import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/ui/widgets/circlular_loader.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: Shapes.mediumShape,
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularLoader(Theme.of(context).colorScheme.secondary),
          SizedBox(height: 16.0),
          Text(
            'Finalizing',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
    ;
  }
}
