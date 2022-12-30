import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/auth/ui/screens/verify_screen.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/utils.dart';

import '../../providers/auth_provider.dart';
import '../widgets/phone_proceed_dialog.dart';

class SignupScreen extends ConsumerWidget with InputValidationMixin {
  SignupScreen({
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

    String? phoneError;
    String? emailError;
    String? passwordError;

    switch (authState) {
      case AuthState.invalidPhone:
        phoneError = 'Not a valid phone number';
        break;
      case AuthState.phoneInUse:
        phoneError = 'An account already exists with this phone number';
        break;
      case AuthState.emailInUse:
        emailError = 'An account already exists with this email';
        break;
      case AuthState.invalidPassword:
        passwordError = 'Password too weak';
        break;
      case AuthState.invalidEmail:
        emailError = 'Not a valid email';
        break;
      case AuthState.error:
        Future.microtask(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occured'),
            ),
          ),
        );
        break;
        // case AuthState.authenticated:
        //   Future.microtask(
        //     () => Navigator.of(context).pushNamedAndRemoveUntil(
        //       CustomerAppRoutes.home,
        //       (route) => false,
        //     ),
        //   );
        break;
      default:
    }

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
                          'Let\'s get you signed up',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Form(
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'John',
                            ),
                            textCapitalization: TextCapitalization.words,
                            onSaved: model.onNameSaved,
                            validator: model.nameValidator,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                hintText: '+2348123456789',
                                errorText: phoneError
                                // icon: CircleAvatar(),
                                ),
                            onSaved: model.onPhoneSaved,
                            validator: model.phoneValidator,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'example123@examples.com',
                              errorText: emailError,
                            ),
                            onSaved: model.onEmailSaved,
                            validator: model.emailValidator,
                          ),
                          const SizedBox(height: 24),
                          Consumer(
                            builder: (context, ref, child) {
                              final obscureText =
                                  ref.watch(_obscureTextProvider);

                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: '••••••••••••',
                                  errorText: passwordError,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText ? Icons.abc : Icons.password,
                                    ),
                                    // color: obscureText
                                    //     ? Theme.of(context).unselectedWidgetColor
                                    //     : null,
                                    onPressed: () {
                                      ref
                                          .read(_obscureTextProvider.state)
                                          .update((state) => state = !state);
                                    },
                                  ),
                                ),
                                obscureText: ref.watch(_obscureTextProvider),
                                onSaved: model.onPasswordSaved,
                                validator: model.passwordValidator,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 3),
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
                          'Have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                        ),
                        InkWell(
                          onTap: onSwapScreen,
                          child: const Text('Sign in'),
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

                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return PhoneProceedDialog(
                                      onProceed: () {
                                        Navigator.of(context).pop();
                                        print('Sign up user');
                                        model.signupUser(
                                          onCodeSent: () => showDialog(
                                            context: context,
                                            builder: ((_) {
                                              return VerifyScreen();
                                            }),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                        style: Theme.of(context)
                            .extension<ButtonThemeExtensions>()
                            ?.filled,
                        child: const Text('Sign up'),
                      ),
                    ),
                    const Spacer(flex: 1),
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
