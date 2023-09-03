import 'package:flutter/material.dart';

class AcctDetailsListTile extends StatelessWidget {
  final String bankName;
  final String acctName;
  final String acctNumber;

  const AcctDetailsListTile({
    super.key,
    required this.bankName,
    required this.acctName,
    required this.acctNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        bankName,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      subtitle: Text(
        acctName,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            acctNumber,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Transform.flip(
            flipX: true,
            child: const Icon(
              Icons.keyboard_arrow_left_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
