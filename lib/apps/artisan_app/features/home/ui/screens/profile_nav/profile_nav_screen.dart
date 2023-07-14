import 'package:flutter/material.dart';
import './widgets/profile_options.dart';
import './widgets/profile_nav_toolbar.dart';
import 'consts.dart';

class ProfileNavScreen extends StatelessWidget {
  const ProfileNavScreen({super.key});

  final isPhotoAvailable = false;
  final double horizontalPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 160),
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(
                          100, 0, 20, 0
                        ),
                        items: ProfileToolBar().buildList().map(
                          (row) => PopupMenuItem(child: row)
                        ).toList(),
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      );
                    },
                    child: const Icon(Icons.more_vert)
                  )
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                const Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(testProfileImage),
                    radius: 42,
                  )
                ),
                Transform.flip(
                  flipX: true,
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Color(0xffA8DADC),
                      value: .85,
                      strokeWidth: 7
                    ),
                  )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                170, 15, 100, 15
                ),
              child: InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      "4.8",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Lato"
                      )
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFF1C644),
                      size: 18.0,
                    )
                  ],
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 100
              ),
              child: Text(
                "John Doe",
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const ProfileOptions()
          ]
        )
      )
    );
  }
}
