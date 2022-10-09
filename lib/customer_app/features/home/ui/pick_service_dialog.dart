import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:handees/theme/theme.dart';

enum WorkDuration { oneTime, contract }

class PickServiceDialog extends StatelessWidget {
  const PickServiceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                PaymentMethods(),
                Divider(
                  height: 32.0,
                  thickness: 8.0,
                ),
                WorkDurationWidget(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop('test');
                  },
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                  child: Text('Proceed'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
          leading: Icon(Icons.money),
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
            leading: Icon(Icons.credit_card),
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
          onTap: () {},
          child: ListTile(
            dense: true,
            title: const Text('Add debit / credit card'),
            leading: Icon(Icons.add_card),
          ),
        )
      ],
    );
  }
}

class WorkDurationWidget extends StatefulWidget {
  const WorkDurationWidget({Key? key}) : super(key: key);

  @override
  State<WorkDurationWidget> createState() => _WorkDurationWidgetState();
}

class _WorkDurationWidgetState extends State<WorkDurationWidget> {
  WorkDuration _workDuration = WorkDuration.oneTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Work Duration',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          minVerticalPadding: 8.0,
          title: const Text('One-time'),
          subtitle: Text(
              'The one-time time duration is for handee services that may be completed under 24hrs'),
          trailing: Radio<WorkDuration>(
            value: WorkDuration.oneTime,
            groupValue: _workDuration,
            onChanged: (value) {
              setState(() {
                _workDuration = value!;
              });
            },
          ),
        ),
        ListTile(
          minVerticalPadding: 8.0,
          title: Text('Contract'),
          subtitle: Text(
              'The contract time duration is for handee services that may not be completed under 24hrs'),
          trailing: Radio<WorkDuration>(
            value: WorkDuration.contract,
            groupValue: _workDuration,
            onChanged: (value) {
              setState(() {
                _workDuration = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
