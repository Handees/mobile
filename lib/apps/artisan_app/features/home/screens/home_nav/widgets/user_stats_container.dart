import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/user_stats_card.dart';

class UserStatsContainer extends StatelessWidget {
  const UserStatsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const UserStatsCard("EARNINGS", Color(0xff4579bd), Color(0xffdae5eb)),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Flexible(
              child: UserStatsCard(
                  "RATINGS", Color(0xfff1c644), Color(0xfffcf4da)),
            ),
            SizedBox(
              width: 16.0,
            ),
            Flexible(
              child: UserStatsCard(
                "ACTIVITY",
                Color(0xff039c53),
                Color.fromRGBO(3, 156, 83, 0.2),
              ),
            )
          ],
        )
      ],
    );
  }
}
