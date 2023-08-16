import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/handee/providers/handee-details.provider.dart';
import 'package:handees/shared/data/handees/handee_options.dart';
import 'package:handees/shared/utils/utils.dart';

class HandeeDetailSelection extends ConsumerWidget {
  final String title;
  final Icon titleIcon;
  final List<HandeeOption> options;
  final String type;
  const HandeeDetailSelection(
      {required this.title,
      required this.titleIcon,
      required this.options,
      required this.type,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String handeeOption = type == HandeeOptionTypes.workDuration
        ? ref.watch(handeeApprovalDetailsProvider).workDurationType
        : type == HandeeOptionTypes.paymentOption
            ? ref.watch(handeeApprovalDetailsProvider).settlement.paymentType
            : '';

    return Column(
      children: [
        Container(
          color: getHexColor('f3f3f4'),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          child: Row(
            children: [
              titleIcon,
              const SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: getHexColor('B9B9BB'),
                    ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: options
                .map<Widget>(
                  (option) => DurationOption(
                    isSelected: handeeOption == option.title,
                    title: option.title,
                    description: option.description,
                    onTap: type == HandeeOptionTypes.workDuration
                        ? () => ref
                            .read(handeeApprovalDetailsProvider.notifier)
                            .updateWorkDuration(option.title)
                        : type == HandeeOptionTypes.paymentOption
                            ? () => ref
                                .read(handeeApprovalDetailsProvider.notifier)
                                .updatePaymentOption(option.title)
                            : () {},
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class DurationOption extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String description;
  final void Function() onTap;
  const DurationOption(
      {required this.isSelected,
      required this.title,
      required this.description,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: getHexColor('a4a1a1'),
                  ),
            ),
          ],
        ),
        trailing: Radio(
          value: isSelected,
          groupValue: true,
          onChanged: (value) {
            onTap();
          },
          activeColor: getHexColor('a8dadc'),
        ),
      ),
    );
  }
}
