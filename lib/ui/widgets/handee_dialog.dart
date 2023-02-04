import 'package:flutter/material.dart';
import 'package:handees/theme/theme_extensions.dart';

Future<T?> showHandeeDialog<T>(
  BuildContext context, {
  required String title,
  String? subtitle,
  Widget? content,
  required String positiveButtonText,
  String? negativeButtonText,
  required void Function() onPositiveButton,
  void Function()? onNegativeButton,
}) {
  // assert(
  //   (positiveButtonText == null && onPositiveButton == null ||
  //           positiveButtonText != null && onPositiveButton != null) &&
  //       (negativeButtonText == null && onNegativeButton == null ||
  //           negativeButtonText != null && onNegativeButton != null),
  //   'Button text and the corresponding button action must be defined',
  // );
  const verticalPadding = 4.0;
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      contentPadding: const EdgeInsets.all(20.0),
      // alignment: Alignment.center,
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.blue,
            shape: CircleBorder(),
          ),
          height: 56,
          width: 56,
          child: const Center(
            child: CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 16,
              child: Icon(Icons.abc),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
              ),
            ),
          ),
        const SizedBox(height: 14),
        if (content != null) content,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: verticalPadding),
          child: ElevatedButton(
            style: Theme.of(context).extension<ButtonThemeExtensions>()?.filled,
            onPressed: () {},
            child: Text(
              positiveButtonText,
            ),
          ),
        ),
        if (negativeButtonText != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            child: ElevatedButton(
              style:
                  Theme.of(context).extension<ButtonThemeExtensions>()?.tonal,
              onPressed: () {},
              child: Text(
                negativeButtonText,
              ),
            ),
          ),
      ],
    ),
  );
}
