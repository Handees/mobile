import 'package:flutter/material.dart';
import 'package:handee/screens/signup_screen.dart';

import 'package:handee/utils/handee_colors.dart';
import 'package:handee/utils/utils.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';

import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth-page';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HandeeColors.backgroundDark,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: _isSignIn
              ? SignInForm(onSignUpTap: () {
                  setState(() {
                    _isSignIn = false;
                  });
                })
              : SignupForm(onSignInTap: () {
                  setState(() {
                    _isSignIn = true;
                  });
                }),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
    required this.onSignUpTap,
  }) : super(key: key);

  final void Function() onSignUpTap;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with InputValidationMixin {
  bool _showPassword = false;
  bool _isLoading = false;
  final _formGlobalKey = GlobalKey<FormState>();

  final Map<String, String> _details = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
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
                  labelText: 'Email',
                  onSaved: (value) {
                    _details['email'] = value!;
                  },
                  validator: (value) {
                    if (value != null) {
                      return isEmailValid(value) || isNumberValid(value)
                          ? null
                          : 'Invalid';
                    }
                    return 'Invalid';
                  },
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  labelText: 'Password',
                  onSaved: (value) {
                    _details['password'] = value!;
                  },
                  validator: (value) {
                    if (value != null) {
                      return isPasswordValid(value) ? null : 'Invalid';
                    }
                    return 'Invalid';
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
                      onTap: widget.onSignUpTap,
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
                  text: _isLoading ? null : 'Sign in',
                  onTap: () {
                    submitForm();
                  },
                  color: HandeeColors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() async {
    if (_formGlobalKey.currentState == null) throw Exception('Form key null');

    if (!_formGlobalKey.currentState!.validate()) return;

    _formGlobalKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    final result = await AuthService.instance.signinUser(_details);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result != 'SUCCESS') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
