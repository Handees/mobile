import 'package:flutter/material.dart';

import 'package:handees/apps/customer_app/features/auth/viewmodels/signin_viewmodel.dart';
import 'package:handees/shared/res/icons.dart';
import 'package:handees/shared/routes/routes.dart';
import 'package:handees/shared/services/auth_service.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({
    Key? key,
  }) : super(key: key);

  final _formGlobalKey = GlobalKey<FormState>();

  final viewModel = SigninViewmodel(AuthService.instance);
  final _obscureTextNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Welcome back!',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          const Spacer(flex: 3),
                          Form(
                            key: _formGlobalKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  // onChanged: (_) => model.resetState(),
                                  onSaved: viewModel.onEmailSaved,
                                  validator: viewModel.emailValidator,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    errorText: viewModel.emailError,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ValueListenableBuilder<bool>(
                                  valueListenable: _obscureTextNotifier,
                                  builder: (context, obscureText, child) {
                                    return TextFormField(
                                      obscureText: obscureText,
                                      onSaved: viewModel.onPasswordSaved,
                                      validator: viewModel.passwordValidator,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
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
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 6),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign in with',
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
                                  'Don\'t have an account? ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .unselectedWidgetColor),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed(AuthRoutes.signup),
                                  child: const Text('Sign up'),
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
                                      viewModel.signinUser(
                                          onSuccess: () {
                                            Future.microtask(
                                              () => Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushReplacementNamed(
                                                      CustomerAppRoutes.home),
                                            );
                                          },
                                          onUnknownError: () {});
                                    },
                              child: const Text('Sign in'),
                            ),
                          ),
                          const Spacer(flex: 1),
                          const SizedBox(height: 8),
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
