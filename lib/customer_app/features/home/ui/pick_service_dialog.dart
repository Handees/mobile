import 'package:flutter/material.dart';
import 'package:handees/routes/routes.dart';
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
          const SliverList(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop('test');
                  },
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                  child: const Text('Proceed'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
          subtitle: const Text(
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
          title: const Text('Contract'),
          subtitle: const Text(
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
