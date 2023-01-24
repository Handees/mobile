import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/home/ui/complete_profile_card.dart';
import 'package:handees/artisan_app/features/home/ui/profile_header.dart';
import 'package:handees/artisan_app/features/home/ui/user_stats_container.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({super.key});

  final isPhotoAvailable = false;
  final double horizontalPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  ProfileHeader(isPhotoAvailable),
                  const SizedBox(height: 48),
                  const CompleteProfileCard(),
                  const SizedBox(height: 48),
                  const UserStatsContainer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
