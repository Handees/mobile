import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/wallet_balance_card.dart';

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
    return Column(
      children: [
        Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              physics: const BouncingScrollPhysics(),
              splashFactory: NoSplash.splashFactory,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
              unselectedLabelColor: Colors.grey,
              labelPadding: const EdgeInsets.only(bottom: 0),
              indicatorColor: Colors.black,
              indicatorWeight: 2.5,
              dividerColor: const Color(0xFFD2D2D2),
              tabs: filters.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: filters.map((tab) {
              //TODO: Replace the below widget with the actual content for each tab.
              return Center(child: Text(tab));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
