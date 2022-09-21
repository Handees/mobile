import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/features/auth/services/auth_service.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/utils.dart';

import '../widgets/auth_textfield.dart';
import '../widgets/phone_proceed_dialog.dart';

class SigninScreen extends ConsumerWidget with InputValidationMixin {
  SigninScreen({Key? key}) : super(key: key);

  final _formGlobalKey = GlobalKey<FormState>();

  final _obscureTextProvider = StateProvider<bool>((ref) {
    return true;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = '';
    String password = '';
    String name = '';

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
                    const Spacer(flex: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 220,
                        child: Text(
                          'Welcome back!',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Form(
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            hintText: 'Phone or email',
                            onSaved: (value) {
                              if (isEmailValid(value!)) {
                                email = value;
                              } else {
                                // number = value;
                              }
                            },
                            validator: (value) {
                              if (value != null &&
                                  (isEmailValid(value) ||
                                      isNumberValid(value))) {
                                return null;
                              }

                              const errorMessage = 'Invalid phone or email';
                              showSnackBar(context, errorMessage);
                              return errorMessage;
                            },
                          ),
                          const SizedBox(height: 24),
                          Consumer(
                            builder: (context, ref, child) {
                              final obscureText =
                                  ref.watch(_obscureTextProvider);

                              return AuthTextField(
                                hintText: 'Password',
                                obscureText: ref.watch(_obscureTextProvider),
                                onSaved: (value) {
                                  password = value!;
                                },
                                icon: IconButton(
                                  icon: Icon(
                                      obscureText ? Icons.abc : Icons.password),
                                  onPressed: () {
                                    ref
                                        .read(_obscureTextProvider.state)
                                        .update((state) => state = !state);
                                  },
                                ),
                                validator: (value) {
                                  if (value != null && isPasswordValid(value)) {
                                    return null;
                                  }

                                  const errorMessage = 'Weak password';
                                  showSnackBar(context, errorMessage);
                                  return errorMessage;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 6),
                    Text(
                      'Sign up with',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).unselectedWidgetColor),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleAvatar(radius: 24.0),
                        CircleAvatar(radius: 24.0),
                        CircleAvatar(radius: 24.0),
                      ],
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).unselectedWidgetColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.signup);
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return const PhoneProceedDialog();
                            },
                          );

                          // if (!_formGlobalKey.currentState!.validate()) return;

                          // _formGlobalKey.currentState?.save();
                          // print(
                          //     'Email: $email, Password: $password, Name: $name');

                          // ref
                          //     .read(authServiceProvider)
                          //     .signupUser(email, password, name);
                        },
                        style: Theme.of(context)
                            .extension<ButtonThemeExtensions>()
                            ?.filled,
                        child: const Text('Sign in'),
                      ),
                    ),
                    const Spacer(flex: 1),
                    const SizedBox(height: 8),
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
