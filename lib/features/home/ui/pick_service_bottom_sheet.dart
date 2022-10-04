import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

import 'service_card.dart';

class PickServiceBottomSheet extends StatelessWidget {
  const PickServiceBottomSheet({Key? key}) : super(key: key);

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
          const ServiceCard(
            serviceName: 'Hair Stylist',
            icon: Icon(Icons.abc),
            iconBackground: Colors.orange,
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
            child: ElevatedButton(
              onPressed: () async {
                final res = await Navigator.of(context)
                    .pushNamed(CustomerAppRoutes.pickService);
                print(res);

                if (res != null)
                  Navigator.of(context).pushNamed(CustomerAppRoutes.tracking);
              },
              style:
                  Theme.of(context).extension<ButtonThemeExtensions>()?.filled,
              child: const Text('Proceed'),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
