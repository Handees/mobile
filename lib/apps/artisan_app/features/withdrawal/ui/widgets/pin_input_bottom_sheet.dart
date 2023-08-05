import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/widgets/custom_keyboard.dart';
import 'package:pinput/pinput.dart';

class PinInputBottomSheet extends StatefulWidget {
  const PinInputBottomSheet({super.key});

  @override
  State<PinInputBottomSheet> createState() => _PinInputBottomSheetState();
}

class _PinInputBottomSheetState extends State<PinInputBottomSheet> {
  final pinInputController = TextEditingController();
  var isLoading = false;
  @override
  void dispose() {
    pinInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = const Color(0xFF14161C).withOpacity(0.3);

    final defaultPinTheme = PinTheme(
      width: 76,
      height: 56,
      textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, style: BorderStyle.solid),
        ),
      ),
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 76,
          height: 0.1,
          decoration: BoxDecoration(
            color: borderColor,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Transaction PIN',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please provide your Handees transaction pin to authorise this withdrawal',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF14161C).withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 32),
          Pinput(
            length: 4,
            pinAnimationType: PinAnimationType.slide,
            controller: pinInputController,
            showCursor: false,
            readOnly: true,
            useNativeKeyboard: false,
            defaultPinTheme: defaultPinTheme,
            preFilledWidget: preFilledWidget,
            separator: const SizedBox(width: 16),
            onCompleted: (value) {
              setState(() {
                isLoading = true;
              });

              showDialog(
                // barrierDismissible: false,
                context: context,
                builder: (context) => Center(
                  child: Container(
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFF14161C),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Please wait',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                ),
              );
              // Navigator.of(context)
              //     .pushReplacementNamed(ArtisanAppRoutes.earnings);
            },
          ),
          const SizedBox(height: 32),
          Text.rich(
            TextSpan(
              text: 'Forgot PIN? ',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).unselectedWidgetColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Reset PIN',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // print('You tapped!');
                    },
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 150),
          CustomKeyboard(controller: pinInputController),
        ],
      ),
    );
  }
}
