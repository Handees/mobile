import 'dart:ui';

import 'package:flutter/material.dart';

class IDialog extends StatelessWidget {
  final Widget child;
  const IDialog({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        child: child,
      ),
    );
  }
}

class DialogContainer extends StatelessWidget {
  final Widget child;
  final double height;
  const DialogContainer({required this.child, this.height = 280, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 36.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}
