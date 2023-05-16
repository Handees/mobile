import 'package:flutter/material.dart';

class BottomTabNavBar extends StatelessWidget {
  const BottomTabNavBar(this._selectedIndex, this._onItemTapped, {super.key});

  final int _selectedIndex;
  final void Function(int) _onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.construction),
          label: "Handees",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xff14161c),
      unselectedItemColor: const Color(0xffc4c4c4),
      selectedLabelStyle: const TextStyle(
        color: Color(0xffc4c4c4),
      ),
      unselectedLabelStyle: const TextStyle(
        color: Color(0xff14161c),
      ),
      onTap: _onItemTapped,
    );
  }
}
