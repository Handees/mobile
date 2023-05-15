import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

class LoadingBottomSheet extends StatelessWidget {
  const LoadingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            // height: 96,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  decoration: ShapeDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    shape: Shapes.mediumShape,
                  ),
                  height: 72,
                  width: 72,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.abc),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Searching for',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hair Stylist',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
