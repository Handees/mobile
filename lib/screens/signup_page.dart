import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/signin_page.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const routeName = '/signup-page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = false;

  final _formGlobalKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 0.04 * size.height),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Let\'s get you signed up!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: HandeeColors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.09 * size.height,
                    ),
                    AuthTextField(
                      labelText: 'Name',
                      onSaved: (value) {
                        log('Name: $value');
                      },
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      labelText: 'Phone or email',
                      onSaved: (value) {
                        log('P or E: $value');
                      },
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                        labelText: 'Password',
                        onSaved: (value) {
                          log('PassWord: $value');
                        },
                        obscureText: !_showPassword,
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
                    HandeeButton(
                      text: 'Sign up',
                      onTap: () {
                        submitForm();
                      },
                      color: HandeeColors.white,
                      textColor: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
      ),
    );
  }

  void submitForm() {
    _formGlobalKey.currentState?.save();
  }
}
