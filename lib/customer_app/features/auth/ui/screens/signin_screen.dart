import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/utils.dart';

import '../../providers/auth_provider.dart';

class SigninScreen extends ConsumerWidget with InputValidationMixin {
  SigninScreen({
    Key? key,
    required this.onSwapScreen,
  }) : super(key: key);

  final void Function() onSwapScreen;

  final _formGlobalKey = GlobalKey<FormState>();

  final _obscureTextProvider = StateProvider<bool>((ref) {
    return true;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authProvider.notifier);
    final authState = ref.watch(authProvider);

    // print('signingstate $authState');

    final emailError = authState == AuthState.noSuchEmail
        ? 'No account exists with this email'
        : null;

    // if (authState == AuthState.authenticated) {
    //   Future.microtask(
    //     () => Navigator.of(context).pushNamedAndRemoveUntil(
    //       CustomerAppRoutes.home,
    //       (route) => false,
    //     ),
    //   );
    // }

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
                          TextFormField(
                            // onChanged: (_) => model.resetState(),
                            onSaved: model.onEmailSaved,
                            validator: model.emailValidator,
                            decoration: InputDecoration(
                              hintText: 'Phone or email',
                              errorText: emailError,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Consumer(
                            builder: (context, ref, child) {
                              final obscureText =
                                  ref.watch(_obscureTextProvider);

                              return TextFormField(
                                obscureText: obscureText,
                                // onChanged: (_) => model.resetState(),
                                onSaved: model.onPasswordSaved,
                                validator: model.passwordValidator,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  errorText:
                                      authState == AuthState.invalidPassword
                                          ? 'Incorrect password'
                                          : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText ? Icons.abc : Icons.password,
                                    ),
                                    color: obscureText
                                        ? Theme.of(context)
                                            .unselectedWidgetColor
                                        : null,
                                    onPressed: () {
                                      ref
                                          .read(_obscureTextProvider.state)
                                          .update((state) => state = !state);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 6),
                    Text(
                      'Sign in with',
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
                          onTap: onSwapScreen,
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authState == AuthState.loading
                            ? null
                            : () {
                                if (!_formGlobalKey.currentState!.validate()) {
                                  return;
                                }
                                _formGlobalKey.currentState?.save();
                                model.signinUser();
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
