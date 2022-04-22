import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';

class HandeeButton extends StatelessWidget {
  const HandeeButton({
    Key? key,
    this.color = HandeeColors.backgroundDark,
    this.textColor = HandeeColors.white,
    this.text,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final void Function() onTap;

  /// Display text for the button. Leaving this field uninitialized or set to null
  /// defaults to a CircularProgressIndicator being displayed.
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          child: text == null
              ? CircularProgressIndicator(
                  color: textColor,
                )
              : Text(
                  text!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: textColor,
                      ),
                ),
        ),
      ),
    );
  }
}
