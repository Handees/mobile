import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomKeyboard extends StatelessWidget {
  final TextEditingController controller;

  /// Button at bottom left corner.
  final Widget? additionalButton;

  /// Callback of button at bottom left corner.
  final VoidCallback? onAdditionalButtonPressed;

  const CustomKeyboard({
    Key? key,
    required this.controller,
    this.additionalButton,
    this.onAdditionalButtonPressed,
  }) : super(key: key);

  final textStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[1, 2, 3].map(
                (index) {
                  return PinButton(
                    onTap: () => controller.append('$index', 4),
                    child: Text(
                      '$index',
                      style: textStyle,
                    ),
                  );
                },
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[4, 5, 6].map(
                (index) {
                  return PinButton(
                    onTap: () => controller.append('$index', 4),
                    child: Text(
                      '$index',
                      style: textStyle,
                    ),
                  );
                },
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[7, 8, 9].map(
                (index) {
                  return PinButton(
                    onTap: () => controller.append('$index', 4),
                    child: Text(
                      '$index',
                      style: textStyle,
                    ),
                  );
                },
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PinButton(
                onTap: () => additionalButton != null
                    ? onAdditionalButtonPressed!()
                    : null,
                child: additionalButton ?? const SizedBox(),
              ),
              PinButton(
                onTap: () => controller.append('0', 4),
                child: Text(
                  '0',
                  style: textStyle,
                ),
              ),
              PinButton(
                onTap: () => controller.delete(),
                child: const Icon(
                  Icons.backspace_rounded,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PinButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;

  const PinButton({
    Key? key,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.transparent,
      child: SizedBox(
        width: 80,
        height: 35,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
