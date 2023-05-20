import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/accept_handee_dialog.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/complete_profile_card.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/online_toggle_card.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/profile_header.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/user_stats_container.dart';
import 'package:handees/shared/data/location/datasources/remote.dart';

class HomeNavScreen extends StatefulWidget {
  const HomeNavScreen({super.key});

  @override
  State<HomeNavScreen> createState() => _HomeNavScreenState();
}

class _HomeNavScreenState extends State<HomeNavScreen> {
  final isProfileComplete = true;

  final double horizontalPadding = 16.0;

  bool isArtisanOnline = false;

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
                  InkWell(
                    onTap: () {
                      showDialog(
                          useRootNavigator: false,
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return const AcceptHandeeDialog();
                          });

                      final locationRDS = LocationRemoteDataSource();
                      locationRDS.updateLocation({
                        "lat": 6.517871336509268,
                        "lon": 3.399740067230001,
                        "artisan_id": "ab8498e6c",
                        "job_category": "carpentary"
                      });
                    },
                    child: ProfileHeader(isProfileComplete),
                  ),
                  const SizedBox(height: 48),
                  isProfileComplete
                      ? OnlineToggleCard(
                          isArtisanOnline,
                          () {
                            setState(() {
                              isArtisanOnline = !isArtisanOnline;
                            });
                          },
                        )
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
