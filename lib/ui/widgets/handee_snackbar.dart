import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

void showSucessSnackBar(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        // clipBehavior: Clip.hardEdge,
        content: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: ShapeDecoration(
              shape: Shapes.smallShape,
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                  blurRadius: 7,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(8.0),
                    ),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 12),
                const CircleAvatar(),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Success',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      'your new card has been added',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
