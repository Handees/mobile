import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/accept_handee_dialog.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/complete_profile_card.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/online_toggle_card.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/profile_header.dart';
import 'package:handees/apps/artisan_app/features/home/ui/screens/home_nav/widgets/user_stats_container.dart';

class HomeNavScreen extends ConsumerStatefulWidget {
  const HomeNavScreen({super.key});

  @override
  ConsumerState<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends ConsumerState<HomeNavScreen> {
  final isProfileComplete = true;

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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          useRootNavigator: false,
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return const AcceptHandeeDialog();
                        });
                      },
                      child: ProfileHeader(isProfileComplete),
                    )
                  ),
                  isProfileComplete
                      ? const OnlineToggleCard()
                      : const CompleteProfileCard(),
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
