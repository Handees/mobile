import 'package:flutter/material.dart';

class IconAvatar extends StatelessWidget {
  const IconAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: ShapeDecoration(
        shape: const CircleBorder(
            side: BorderSide(
          color: Color(0xffe5e5e5),
        )),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: const Icon(Icons.account_circle),
    );
  }
}
