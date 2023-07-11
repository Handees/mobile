import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/screens/current_week_tab_screen.dart';
import 'package:handees/apps/artisan_app/features/withdrawal/ui/widgets/wallet_balance_card.dart';

class ArtisanEarningsScreen extends StatelessWidget {
  const ArtisanEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> tabs = [
      'Current week',
      'Past 1 month',
      'Past 3 months',
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Earnings'),
          scrolledUnderElevation: 0,
        ),
        body: const Column(
          children: [
            SizedBox(height: 35),
            WalletBalanceCard(),
            SizedBox(height: 35),
            Expanded(child: TabFilters(filters: tabs)),
          ],
        ),
      ),
    );
  }
}

class TabFilters extends StatelessWidget {
  const TabFilters({super.key, required this.filters});

  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Align(
            child: TabBar(
              physics: const BouncingScrollPhysics(),
              splashFactory: NoSplash.splashFactory,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              unselectedLabelColor: const Color(0xFFAEAEAE),
              labelPadding: const EdgeInsets.only(),
              indicatorColor: Colors.black,
              indicatorWeight: 2.5,
              dividerColor: const Color(0xFFD2D2D2),
              tabs: filters.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          const SizedBox(height: 30),
          const Expanded(
            child: TabBarView(
              children: [
                CurrentWeekScreen(),
                // TODO: Add other screens
                // Test
                CurrentWeekScreen(),
                CurrentWeekScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
