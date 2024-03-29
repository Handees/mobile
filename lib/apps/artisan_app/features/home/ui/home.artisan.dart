import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/handee/ui/handee_nav/handee_screen.dart';
import 'package:handees/apps/artisan_app/features/profile/ui/profile_nav/profile_nav_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:handees/apps/artisan_app/features/home/ui/home_nav/home_nav_screen.dart';

class ArtisanHomeScreen extends StatefulWidget {
  const ArtisanHomeScreen({super.key});

  @override
  State<ArtisanHomeScreen> createState() => _ArtisanHomeScreenState();
}

class _ArtisanHomeScreenState extends State<ArtisanHomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeNavScreen(),
    HandeeNavScreen(),
    ProfileNavScreen(),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomTabNavBar(_selectedIndex, _onItemTapped));
  }
}
