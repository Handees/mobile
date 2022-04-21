import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/signin_page.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const routeName = '/signup-page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        'Let\'s get you signed up!',
                        textScaleFactor: 2,
                        style: TextStyle(
                          color: HandeeColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.09 * size.height,
                  ),
                  AuthTextField(labelText: 'Name'),
                  const SizedBox(height: 25),
                  AuthTextField(labelText: 'Phone or email'),
                  const SizedBox(height: 25),
                  AuthTextField(
                      labelText: 'Password',
                      icon: GestureDetector(
                        child: Icon(
                          _showPassword
                              ? HandeeIcons.eye_tracking_on
                              : HandeeIcons.eye_tracking_off,
                          color: _showPassword
                              ? HandeeColors.grey237
                              : HandeeColors.grey89,
                        ),
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )),
                  SizedBox(height: 0.07 * size.height),
                  const Text(
                    'Sign up with',
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
                        'Have an account? ',
                        style: TextStyle(
                          color: HandeeColors.alteWhite,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed(SigninPage.routeName),
                        child: const Text(
                          'Sign in',
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
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: HandeeColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 30,
                    child: Text(
                      'By clicking Sign up, you agree to our User Agreement and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: HandeeColors.grey161),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
