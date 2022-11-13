import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/customer_app/features/payments/providers/add_card_provider.dart';
import 'package:handees/theme/theme.dart';

class AddCardScreen extends ConsumerWidget {
  AddCardScreen({super.key});

  final publicKey = 'pk_test_b5719f814c430f6723ab0467246b39796ef405b6';
  final plugin = PaystackPlugin();

  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    plugin.initialize(publicKey: publicKey);

    final model = ref.watch(addCardProvider.notifier);
    final state = ref.watch(addCardProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Form(
          key: _formGlobalKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  width: 280,
                  height: 172,
                  color: Colors.red,
                ),
                Spacer(),
                AddCardField(
                  labelText: 'CARD NUMBER',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  autofillHints: [AutofillHints.creditCardNumber],
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  onSaved: model.onCardNumberSaved,
                  inputFormatters: [
                    // TextInputFormatter.withFunction((oldValue, newValue) {
                    //   print('oldValue $oldValue newvalue $newValue');
                    //   // return TextEditingValue(
                    //   //     text: 'hey',
                    //   //     selection: TextSelection.collapsed(offset: -1));
                    //   print('length is ${oldValue.text.length}');
                    //   if (oldValue.text.length % 4 == 0) {
                    //     print('aha');

                    //     return newValue.copyWith(
                    //       text: 'Yo', //newValue.text.padRight(1, '-'),
                    //     );
                    //   }

                    //   return newValue;
                    // })
                  ],
                ),
                SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: AddCardField(
                        labelText: 'EXPIRY DATE',
                        autofillHints: [AutofillHints.creditCardExpirationDate],
                        hintText: 'MM/YY',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onSaved: model.onExpiryDateSaved,
                        inputFormatters: [],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: AddCardField(
                        labelText: 'CVV/CSV',
                        autofillHints: [AutofillHints.creditCardSecurityCode],
                        hintText: 'XXX',
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        onSaved: model.onSecurityCodeSaved,
                        inputFormatters: [],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _formGlobalKey.currentState?.save();

                      print(model.testCheck());

                      final response = await plugin.chargeCard(context,
                          charge: await model.test());

                      print('Response $response');
                      // Use the response
                    },
                    style: Theme.of(context)
                        .extension<ButtonThemeExtensions>()
                        ?.filled,
                    child: const Text('Done'),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddCardField extends StatelessWidget {
  const AddCardField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.autofillHints,
    required this.keyboardType,
    required this.maxLength,
    required this.onSaved,
    required this.inputFormatters,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Iterable<String> autofillHints;
  final TextInputType keyboardType;
  final int maxLength;
  final void Function(String?) onSaved;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
        ),
        TextFormField(
          style: TextStyle(
            letterSpacing: 1.5,
          ),
          maxLength: maxLength,
          keyboardType: keyboardType,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[0-9]'),
            ),
            ...inputFormatters,
          ],
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 1.5,
            ),
          ),
          onSaved: onSaved,
          autofillHints: autofillHints,
        ),
      ],
    );
  }
}
