import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_stats_card.dart';

class UserStatsContainer extends StatelessWidget {
  const UserStatsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        UserStatsCard("EARNINGS", Color(0xff4579bd), Color(0xffdae5eb)),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
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
