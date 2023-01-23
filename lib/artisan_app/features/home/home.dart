import 'package:flutter/material.dart';
import 'package:handees/artisan_app/features/home/ui/bottom_nav_bar.dart';
import 'package:handees/artisan_app/features/home/ui/home_nav_screen.dart';

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
    Text(
      'Index 1: Handees',
      style: optionStyle,
    ),
    Text(
      'Index 2: Profile',
      style: optionStyle,
    ),
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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Home Screen"),
              _widgetOptions[_selectedIndex]
            ],
          ),
        ),
        bottomNavigationBar: BottomTabNavBar(_selectedIndex, _onItemTapped));
  }
}
