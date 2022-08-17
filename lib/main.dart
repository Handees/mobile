import 'package:flutter/material.dart';
import 'package:handees/features/auth/ui/signup_screen.dart';
import 'package:handees/features/home/ui/home_screen.dart';
import 'package:handees/routes/routes.dart';

import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handees',
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
