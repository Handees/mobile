import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  static const routeName = '/signin-page';

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> with InputValidationMixin {
  bool _showPassword = false;
  bool _isLoading = false;
  final _formGlobalKey = GlobalKey<FormState>();

  final Map<String, String> _details = {};

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
                        labelText: 'Email',
                        onSaved: (value) {
                          log('Name: $value');
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
                          log('Password: $value');
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
                      SizedBox(height: 40)
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

  void submitForm() async {
    if (!_formGlobalKey.currentState!.validate()) return;

    _formGlobalKey.currentState?.save();

    try {
      setState(() {
        _isLoading = true;
      });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _details['email']!,
        password: _details['password']!,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = e.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      log("Auth Execption: " + e.toString());
      rethrow;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const routeName = '/signup-page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with InputValidationMixin {
  bool _showPassword = false;
  bool _isLoading = false;

  final _formGlobalKey = GlobalKey<FormState>();
  final Map<String, String> _details = {};

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
                        log('Saving Name: $value');
                        _details['name'] = value!;
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return 'Invalid';
                      },
                    ),
                    const SizedBox(height: 25),
                    AuthTextField(
                      labelText: 'Phone or email',
                      onSaved: (value) {
                        log('Saving P or E: $value');
                        if (isEmailValid(value!)) {
                          log('Is email');
                          _details['email'] = value;
                        } else {
                          log('Is number');
                          _details['number'] = value;
                        }
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
                          log('Saving PassWord: $value');
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
                      text: _isLoading ? null : 'Sign up',
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

  void submitForm() async {
    if (!_formGlobalKey.currentState!.validate()) return;

    _formGlobalKey.currentState?.save();

    try {
      setState(() {
        _isLoading = true;
      });
      final credential = true
          ? await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _details['email']!,
              password: _details['password']!,
            )
          : null; //TODO: Create phone sign-in;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occured';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      log("Auth Execption: " + e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

mixin InputValidationMixin {
  bool isEmailValid(String email) {
    var pattern = r'^\S+@\S+\.\S+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    var light = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$';
    var extreme =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    var regex = RegExp(light);

    return regex.hasMatch(password);
  }

  bool isNumberValid(String number) {
    var pattern = r'^[0-9-+\s]+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(number);
  }
}
