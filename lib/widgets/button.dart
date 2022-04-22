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
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class HandeeLoader extends StatelessWidget {
  const HandeeLoader({
    Key? key,
    this.backgroundColor = HandeeColors.backgroundDark,
    this.foregroundColor = HandeeColors.white,
  }) : super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        child: CircularProgressIndicator(
          color: foregroundColor,
        ),
      ),
    );
  }
}
