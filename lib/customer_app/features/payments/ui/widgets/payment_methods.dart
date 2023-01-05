import 'package:flutter/material.dart';
import 'package:handees/routes/routes.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  final paymentCards = const [
    "**** 9847",
    "**** 9235",
  ];

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  var _value = 'cash';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'Payment Methods',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          dense: true,
          title: const Text('Cash / Bank Transfer'),
          leading: const Icon(Icons.money),
          trailing: Radio<String>(
            value: 'cash',
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!;
              });
            },
          ),
        ),
        for (String card in widget.paymentCards)
          ListTile(
            dense: true,
            title: Text(card),
            leading: const Icon(Icons.credit_card),
            trailing: Radio<String>(
              value: card,
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value!;
                });
              },
            ),
          ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CustomerAppRoutes.addCard);
          },
          child: const ListTile(
            dense: true,
            title: Text('Add debit / credit card'),
            leading: Icon(Icons.add_card),
          ),
        )
      ],
    );
  }
}
