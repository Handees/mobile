import "package:flutter/material.dart";

class SwapButton extends StatelessWidget {
  const SwapButton(this.onClick, {super.key});

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      child: const Icon(
        Icons.swap_horiz,
      ),
    );
  }
}
