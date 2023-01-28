import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/routes/auth/routes.dart';
import 'package:handees/routes/customer_app/routes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/utils.dart';

import '../../providers/auth_provider.dart';
import '../widgets/phone_proceed_dialog.dart';

final _obscureTextProvider = StateProvider<bool>((ref) {
  return true;
});

class SignupScreen extends ConsumerWidget with InputValidationMixin {
  SignupScreen({
    Key? key,
  }) : super(key: key);

  final _formGlobalKey = GlobalKey<FormState>();

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
            const SnackBar(
              content: Text('An error occured'),
            ),
          ),
        );
        break;
      case AuthState.authenticated:
        Future.microtask(
          () => Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(CustomerAppRoutes.home),
        );
        break;
      default:
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 4),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                      child: Text(
                        'Let\'s get you signed up',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Form(
                      key: _formGlobalKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            onSaved: model.onNameSaved,
                            validator: model.nameValidator,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              hintText: 'John',
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onSaved: model.onPhoneSaved,
                            validator: model.phoneValidator,
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                hintText: '+2348123456789',
                                errorText: phoneError
                                // icon: CircleAvatar(),
                                ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: model.onEmailSaved,
                            validator: model.emailValidator,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'example123@examples.com',
                              errorText: emailError,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Consumer(
                            builder: (context, ref, child) {
                              final obscureText =
                                  ref.watch(_obscureTextProvider);

                              return TextFormField(
                                keyboardType: TextInputType.visiblePassword,
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
                                          .update((state) => !state);
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign up with',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).unselectedWidgetColor),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Have an account? ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(AuthRoutes.signin),
                            child: const Text('Sign in'),
                          ),
                        ],
                      ),
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
                                        Navigator.of(ctx).pop();
                                        model.signupUser(
                                          onCodeSent: () =>
                                              Navigator.of(context)
                                                  .pushNamed(AuthRoutes.verify),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'By clicking Sign up, you agree to '
                        'our User Agreement and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}