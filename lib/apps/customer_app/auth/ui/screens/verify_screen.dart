import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/services/auth_service.dart';
import 'package:handees/theme/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../providers/auth_provider.dart';
import '../../viewmodels/signup_viewmodel.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({Key? key, required this.model, required this.verifyNumber})
      : super(key: key);

  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  final SignupNotifier model;

  final void Function() verifyNumber;

  @override
  Widget build(BuildContext context) {
    const verticalMargin = 24.0;

    // final model = ref.watch(authProvider.notifier);
    // final authState = ref.watch(authProvider);

    return AnimatedBuilder(
        animation: model,
        builder: (context, _) {
          if (model.verificationCodeError) {
            print('Shake');
            errorController.add(ErrorAnimationType.shake);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Verify Phone'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  Text('Code has been sent to *** ***${model.last2Digits}'),
                  const SizedBox(height: verticalMargin),
                  SizedBox(
                    width: double.infinity,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (value) {
                        model.smsCode = value;
                      },
                      onCompleted: (_) => verifyNumber(),
                      keyboardType: TextInputType.number,
                      errorAnimationController: errorController,
                      pinTheme: PinTheme(
                        borderRadius: BorderRadius.circular(4.0),
                        shape: PinCodeFieldShape.box,
                        activeColor: Theme.of(context).unselectedWidgetColor,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        inactiveColor: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: verticalMargin),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Didn\'t get code? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).unselectedWidgetColor,
                            ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text('Request again'),
                      ),
                    ],
                  ),
                  const SizedBox(height: verticalMargin),
                  InkWell(
                    onTap: () {
                      // errorController.close()
                    },
                    child: const Text('Get via call'),
                  ),
                  const SizedBox(height: verticalMargin),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: model.loading ? null : () => verifyNumber(),
                      child: const Text('Verify and Create Account'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
