import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/signup_page.dart';
import 'package:handee/widgets/auth_screen/auth_checkbox.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';

class SigninPage extends StatelessWidget {
  SigninPage({Key? key}) : super(key: key);

  static const routeName = '/signin-page';

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: HandeeColors.backgroundDark,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 0.04 * size.height),
                    const Text(
                      'Welcome back!',
                      textScaleFactor: 2,
                      style: TextStyle(
                        color: HandeeColors.white,
                      ),
                    ),
                    SizedBox(
                      height: 0.1 * size.height,
                    ),
                    AuthTextField(
                      labelText: 'Name',
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      labelText: 'Password',
                      icon: const PeakIconButton(
                        HandeeIcons.eye_tracking_off,
                        HandeeIcons.eye_tracking_on,
                      ),
                    ),
                    SizedBox(height: 0.07 * size.height),
                    const Text(
                      'Sign in with',
                      style: TextStyle(
                        color: HandeeColors.alteWhite,
                      ),
                    ),
                    SizedBox(height: 0.04 * size.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          HandeeIcons.facebook,
                          color: HandeeColors.white,
                          size: 46,
                        ),
                        Icon(
                          HandeeIcons.google,
                          color: HandeeColors.white,
                          size: 46,
                        ),
                        Icon(
                          HandeeIcons.twitter,
                          color: HandeeColors.white,
                          size: 46,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.05 * size.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: HandeeColors.alteWhite,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed(SignupPage.routeName),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: HandeeColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.05 * size.height),
                    Container(
                      alignment: Alignment.center,
                      height: 58,
                      width: double.infinity,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: HandeeColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 0.00010 * (size.height * size.height),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
