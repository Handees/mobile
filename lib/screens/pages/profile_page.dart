import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final name = 'Barbara';
  final tileHeight = 50.0;
  final padding = const EdgeInsets.symmetric(horizontal: 35.0);
  final dividerColor = const Color.fromRGBO(150, 162, 168, 0.12);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Account',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                  color: HandeeColors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: HandeeColors.white,
                    ),
                    Text(
                      name,
                      style: const TextStyle(color: HandeeColors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 5,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Profile'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Saved'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Pending Reviews'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Recently Viewed'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Customer Support'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('FAQ'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Settings'),
                    ),
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: dividerColor,
                ),
                Padding(
                  padding: padding,
                  child: SizedBox(
                    height: tileHeight,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Log out',
                        style: TextStyle(color: HandeeColors.red),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: dividerColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: HandeeButton(
                text: 'Become a Service Provider',
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
