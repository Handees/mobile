import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        width: 211.5,
        height: 84,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD2D2D2),
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadius.circular(11),
          border: const Border.fromBorderSide(
            BorderSide(
              color: Color(0xFFD2D2D2),
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF000000).withOpacity(0.1),
              ),
              child: SvgPicture.asset(
                "assets/svg/wallet.svg",
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "WALLET BALANCE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "₦300,000",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
