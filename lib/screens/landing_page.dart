import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/signin_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HandeeColors.backgroundDark,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushReplacementNamed(SigninPage.routeName),
            child: Image.asset('assets/images/handee_logo.png'),
          ),
        ),
      ),
    );
  }
}
