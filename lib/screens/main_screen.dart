import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/screens/pages/bookings_page.dart';
import 'package:handee/screens/pages/categories_page.dart';
import 'package:handee/screens/pages/notifications_page.dart';
import 'package:handee/screens/pages/home_page.dart';
import 'package:handee/screens/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final username = 'Barbara';

  final pages = <Widget>[];

  var _index = 0;

  @override
  void initState() {
    pages.addAll([
      HomePage(username: username),
      const CategoriesPage(),
      const NotificationsPage(),
      const BookingsPage(),
      const ProfilePage(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _index == 0
          ? AppBar(
              backgroundColor: HandeeColors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      // icon: CircleAvatar(
                      //   backgroundColor: HandeeColors.grey196,
                      //   child: Icon(
                      //     Icons.person,
                      //     color: HandeeColors.white,
                      //   ),
                      // ),
                      icon: const Icon(
                        Icons.account_circle,
                        color: HandeeColors.grey196,
                        size: 30,
                      )),
                )
              ],
              elevation: 0,
            )
          : null,
      backgroundColor: HandeeColors.white,
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: HandeeColors.shadowBlack,
              blurRadius: 10,
            )
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: HandeeColors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                HandeeIcons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                HandeeIcons.categories,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                HandeeIcons.notifications_bell,
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                HandeeIcons.bookings,
              ),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                HandeeIcons.user,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          selectedItemColor: HandeeColors.black,
          selectedIconTheme: const IconThemeData(
            color: HandeeColors.black,
          ),
          unselectedIconTheme: const IconThemeData(
            color: HandeeColors.grey161,
          ),
        ),
      ),
    );
  }
}
