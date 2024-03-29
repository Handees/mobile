import 'package:flutter/material.dart';

import 'package:handees/shared/data/handees/job_category.dart';

import 'service_card.dart';

class PickServiceBottomSheet extends StatelessWidget {
  const PickServiceBottomSheet({
    Key? key,
    required this.category,
    required this.onClick,
  }) : super(key: key);

  final JobCategory category;
  final VoidCallback onClick;

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
          ServiceCard(
            serviceName: category.name,
            icon: Icon(
              category.icon,
              color: Colors.white,
            ),
            iconBackground: category.foregroundColor,
            artisanCount: 13,
          ),
          const SizedBox(height: 8.0),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.error_outline),
              hintText:
                  'Additional information e.g ‘this is the hair style I want...’',
              hintMaxLines: 1,
            ),
            minLines: 1,
            maxLines: 4,
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onClick,
              child: const Text('Proceed'),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
