import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/complete_profile_card.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/profile_header.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/user_stats_container.dart';

class ProfileNavScreen extends StatelessWidget {
  const ProfileNavScreen({super.key});

  final isPhotoAvailable = false;
  final double horizontalPadding = 16.0;

  final String ronaldoImageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Profile",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Icon(Icons.more_vert)
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(ronaldoImageUrl),
                        radius: 50,
                      ),
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          color: Color(0xffa8dadc),
                          value: 0.78,
                          strokeWidth: 5,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
