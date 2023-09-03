import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/widgets/account_details_list_tile.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/widgets/amount_bottom_sheet.dart';

class BankAcctBottomSheet extends StatelessWidget {
  const BankAcctBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Choose your bank account',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (sheetCtx) => const AmountBottomSheet(),
              );
            },
            child: const AcctDetailsListTile(
              bankName: 'Access Bank',
              acctName: 'Jane Cooper',
              acctNumber: '2527537442',
            ),
          ),
          Divider(
            color: const Color(0xFF000000).withOpacity(0.2),
          ),
          GestureDetector(
            child: const AcctDetailsListTile(
              bankName: 'Kuda Bank',
              acctName: 'Jane Cooper',
              acctNumber: '2560594373',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Bank'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
