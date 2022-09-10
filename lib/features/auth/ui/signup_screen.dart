import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Spacer(flex: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 220,
                        child: Text(
                          'Let\'s get you signed up',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                    Form(
                      child: Column(
                        children: [
                          AuthTextField(
                            hintText: 'Name',
                          ),
                          SizedBox(height: 24),
                          AuthTextField(
                            hintText: 'Phone or email',
                          ),
                          SizedBox(height: 24),
                          AuthTextField(
                            hintText: 'Password',
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 3),
                    Text('Sign up with'),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(radius: 24.0),
                        CircleAvatar(radius: 24.0),
                        CircleAvatar(radius: 24.0),
                      ],
                    ),
                    Spacer(flex: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Have an account? '),
                        InkWell(
                          onTap: () {},
                          child: Text('Sign in'),
                        ),
                      ],
                    ),
                    Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text('AlertDialog Title'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 128,
                                    decoration: ShapeDecoration(
                                      shape: Shapes.mediumShape,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                      'You’ll receive a 4 digit code to verify'),
                                  SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        // width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Use Email'),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        // width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed(AppRoutes.verify),
                                          child: Text('Continue'),
                                          style: Theme.of(context)
                                              .extension<
                                                  ButtonThemeExtensions>()
                                              ?.filled,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        style: Theme.of(context)
                            .extension<ButtonThemeExtensions>()
                            ?.filled,
                        child: Text('Sign up'),
                      ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      'By clicking Sign up, you agree to '
                      'our User Agreement and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends FormField<String> {
  AuthTextField({
    Key? key,
    required String hintText,
    String? labelText,
    Widget? icon,
    TextEditingController? controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String initialValue = '',
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool obscureText = false,
    // Function()? onEditingComplete,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(state.context).colorScheme.onBackground,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TextField(
                // onEditingComplete: onEditingComplete,
                onChanged: (value) {
                  state.didChange(value);
                },
                controller: controller,
                obscureText: obscureText,
                // cursorColor: HandeeColors.white,
                // style: const TextStyle(color: HandeeColors.white),

                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  hintText: hintText,
                  suffixIcon: icon,
                ),
              ),
            );
          },
        );
}
