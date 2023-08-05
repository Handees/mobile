import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/widgets/bank_account_bottom_sheet.dart';

class CurrentWeekScreen extends StatelessWidget {
  const CurrentWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TOTAL EARNINGS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          "₦40,000",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: "0.2% ",
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xff039c53),
            ),
            children: [
              WidgetSpan(
                child: SvgPicture.asset(
                  "assets/svg/graph_icon.svg",
                ),
              ),
              TextSpan(
                text: " vs last week",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300,
        ),
        SizedBox(
          width: double.infinity,
          height: 64,
          child: FilledButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (sheetCtx) {
                    return const BankAcctBottomSheet();
                  });
            },
            child: const Text(
              'Withdraw Funds',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
