import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';

class HandeeButton extends StatelessWidget {
  const HandeeButton({
    Key? key,
    this.color = HandeeColors.backgroundDark,
    this.textColor = HandeeColors.white,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final void Function() onTap;
  final String text;

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
          child: Text(
            text,
            textScaleFactor: 1,
            style: const TextStyle(
              color: HandeeColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
