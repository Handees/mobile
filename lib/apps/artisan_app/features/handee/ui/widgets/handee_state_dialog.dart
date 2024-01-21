import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/shared_widgets/i_dialog.dart';
import 'package:handees/shared/utils/utils.dart';

class HandeeStateDialog extends StatelessWidget {
  final bool isComplete;
  const HandeeStateDialog({required this.isComplete, super.key});

  @override
  Widget build(BuildContext context) {
    return IDialog(
      child: DialogContainer(
        child: Column(
          children: [
            Icon(
              isComplete ? Icons.check_circle : Icons.cancel,
              size: 50,
              color: isComplete ? getHexColor('39ba70') : getHexColor('eb5757'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your handee is ${isComplete ? 'complete' : 'incomplete'}!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'According to your customer, your services are incomplete',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: getHexColor('a4a1a1'),
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Got it',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        letterSpacing: .64,
                        color: Colors.white,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
