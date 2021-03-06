import 'package:flutter/material.dart';

import 'package:handee/utils/handee_colors.dart';
import 'package:handee/screens/auth_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 1)).then((_) {
    //   if (Navigator.canPop(context))
    //     Navigator.of(context).pushNamed(SigninPage.routeName);
    // });

    return Scaffold(
      backgroundColor: HandeeColors.backgroundDark,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Image.asset('assets/images/handee_logo.png'),
        ),
      ),
    );
  }
}
