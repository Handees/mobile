import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

class PhoneProceedDialog extends StatelessWidget {
  const PhoneProceedDialog({
    Key? key,
  }) : super(key: key);

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
            decoration: ShapeDecoration(
              shape: Shapes.mediumShape,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 24),
          Text('You’ll receive a 4 digit code to verify'),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Use Email'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.verify),
                  child: Text('Continue'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
