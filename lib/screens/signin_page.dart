import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/signup_page.dart';
import 'package:handee/widgets/auth_screen/auth_checkbox.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  static const routeName = '/signin-page';

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _showPassword = false;

  final _formGlobalKey = GlobalKey<FormState>();

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
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 0.04 * size.height),
                      Text(
                        'Welcome back!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: HandeeColors.white),
                      ),
                      SizedBox(
                        height: 0.1 * size.height,
                      ),
                      AuthTextField(
                        labelText: 'Name',
                        onSaved: (value) {
                          log('Name: $value');
                        },
                      ),
                      const SizedBox(height: 25),
                      AuthTextField(
                        labelText: 'Password',
                        onSaved: (value) {
                          log('Password: $value');
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
                      HandeeButton(
                        text: 'Sign in',
                        onTap: () {
                          submitForm();
                        },
                        color: HandeeColors.white,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
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
