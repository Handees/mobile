import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/payments/providers/add_card_provider.dart';
import 'package:handees/res/constants.dart';

class AddCardScreen extends ConsumerWidget {
  AddCardScreen({super.key});

  final plugin = PaystackPlugin()
    ..initialize(
      publicKey: AppConstants.paystackPublicKey,
    );

  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                const Spacer(),
                Container(
                  width: 280,
                  height: 172,
                  color: Colors.red,
                ),
                const Spacer(),
                AddCardField(
                  labelText: 'CARD NUMBER',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  autofillHints: const [AutofillHints.creditCardNumber],
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  onSaved: model.onCardNumberSaved,
                  inputFormatters: const [
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
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: AddCardField(
                        labelText: 'EXPIRY DATE',
                        autofillHints: const [
                          AutofillHints.creditCardExpirationDate
                        ],
                        hintText: 'MM/YY',
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onSaved: model.onExpiryDateSaved,
                        inputFormatters: const [],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AddCardField(
                        labelText: 'CVV/CSV',
                        autofillHints: const [
                          AutofillHints.creditCardSecurityCode
                        ],
                        hintText: 'XXX',
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        onSaved: model.onSecurityCodeSaved,
                        inputFormatters: const [],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      _formGlobalKey.currentState?.save();

                      final response = await plugin.chargeCard(context,
                          charge: await model.getCharge());

                      print('Response $response');
                      // Use the response
                    },
                    child: const Text('Done'),
                  ),
                ),
                const Spacer(),
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
          style: const TextStyle(
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
            hintStyle: const TextStyle(
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
