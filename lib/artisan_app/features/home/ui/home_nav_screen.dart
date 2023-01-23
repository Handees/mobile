import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 0: Home',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
