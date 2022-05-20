import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/auth_screen/auth_textfield.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';

import '../services/auth_service.dart';

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

    if (result == 'SUCCESS') {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
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
                        if (isEmailValid(value!)) {
                          _details['email'] = value;
                        } else {
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
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
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

    setState(() {
      _isLoading = true;
    });

    final result = await AuthService.instance.signupUser(_details);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (result == 'SUCCESS') {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
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
    // var extreme =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$';
    var regex = RegExp(light);

    return regex.hasMatch(password);
  }

  bool isNumberValid(String number) {
    var pattern = r'^[0-9-+\s]+$';
    var regex = RegExp(pattern);

    return regex.hasMatch(number);
  }
}
