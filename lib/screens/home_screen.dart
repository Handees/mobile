import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/home_screen/pages/bookings_page.dart';
import 'package:handee/widgets/home_screen/pages/categories_page.dart';
import 'package:handee/widgets/home_screen/pages/notifications_page.dart';
import 'package:handee/widgets/home_screen/pages/home_page.dart';
import 'package:handee/widgets/home_screen/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key) {}

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final username = 'Barbara';

  final pages = <Widget>[];

  var _index = 0;

  @override
  void initState() {
    pages.addAll([
      HomePage(username: username),
      CategoriesPage(),
      NotificationsPage(),
      BookingsPage(),
      ProfilePage(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _index == 0 ? AppBar(
        backgroundColor: HandeeColors.white,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: HandeeColors.textDark,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
                onPressed: () {},
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
      ) : null,
      drawer: const Drawer(),
      backgroundColor: HandeeColors.white,
      body: pages[_index],
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
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_none,
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.playlist_add_check,
              ),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
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
          ),        ),
      ),
    );
  }
}
