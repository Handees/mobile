import 'package:flutter/material.dart';
import 'package:handees/apps/customer_app/home/ui/swap_button.dart';
import 'package:handees/routes/routes.dart';

class SwapAppBottomSheet extends StatelessWidget {
  const SwapAppBottomSheet({
    Key? key,
  }) : super(key: key);

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
          Align(
            alignment: Alignment.centerLeft,
            child: SwapButton(() {}),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Switch Apps",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Are you sure you would like to switch to the handee-man app?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                final res = await Navigator.of(context, rootNavigator: true)
                    .pushNamed(ArtisanAppRoutes.home);
                print(res);
              },
              child: const Text('Switch to handee-man'),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
