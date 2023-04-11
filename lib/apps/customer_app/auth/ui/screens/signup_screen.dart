import 'package:flutter/material.dart';

import 'package:handees/res/icons.dart';
import 'package:handees/routes/pages.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/theme/theme.dart';

import '../../viewmodels/signup_viewmodel.dart';
import '../widgets/phone_proceed_dialog.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({
    Key? key,
  }) : super(key: key);

  final _formGlobalKey = GlobalKey<FormState>();

  final viewModel = SignupNotifier(AuthService.instance);

  final _obscureTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
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
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 4.0),
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
                                  onSaved: viewModel.onNameSaved,
                                  validator: viewModel.nameValidator,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'John',
                                  ),
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onSaved: viewModel.onPhoneSaved,
                                  validator: viewModel.phoneValidator,
                                  decoration: InputDecoration(
                                      labelText: 'Phone',
                                      hintText: '+2348123456789',
                                      errorText: viewModel.phoneError
                                      // icon: CircleAvatar(),
                                      ),
                                ),
                                const SizedBox(height: 24),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: viewModel.onEmailSaved,
                                  validator: viewModel.emailValidator,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'example123@examples.com',
                                    errorText: viewModel.emailError,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ValueListenableBuilder<bool>(
                                  valueListenable: _obscureTextNotifier,
                                  builder: (context, obscureText, child) {
                                    return TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: '••••••••••••',
                                        errorText: viewModel.passwordError,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscureText
                                                ? HandeeIcons.eye_tracking_off
                                                : HandeeIcons.eye_tracking_on,
                                          ),
                                          color: obscureText
                                              ? Theme.of(context)
                                                  .unselectedWidgetColor
                                              : null,
                                          onPressed: () {
                                            _obscureTextNotifier.value =
                                                !obscureText;
                                          },
                                        ),
                                      ),
                                      obscureText: obscureText,
                                      onSaved: viewModel.onPasswordSaved,
                                      validator: viewModel.passwordValidator,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor),
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
                                        color: Theme.of(context)
                                            .unselectedWidgetColor,
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
                            child: FilledButton(
                              onPressed: viewModel.loading
                                  ? null
                                  : () {
                                      if (!_formGlobalKey.currentState!
                                          .validate()) {
                                        return;
                                      }
                                      _formGlobalKey.currentState?.save();

                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return PhoneProceedDialog(
                                            onProceed: () {
                                              Navigator.of(ctx).pop();
                                              viewModel.signupUser(
                                                onCodeSent: (
                                                        {required onVerifyNumber}) =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => Theme(
                                                      data: authTheme,
                                                      child: VerifyScreen(
                                                        verifyNumber:
                                                            onVerifyNumber,
                                                        model: viewModel,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onVerificationComplete: () {
                                                  print('Complete?');
                                                  Future.microtask(
                                                    () => Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pushReplacementNamed(
                                                            CustomerAppRoutes
                                                                .home),
                                                  );
                                                },
                                                onUnkownError: () {
                                                  Future.microtask(
                                                    () => ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'An error occured'),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
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
        });
  }
}
