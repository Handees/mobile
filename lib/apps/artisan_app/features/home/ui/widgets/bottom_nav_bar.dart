import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svg extends StatelessWidget {
  final String url;
  const Svg(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SvgPicture.asset(url, width: 24, height: 24),
    );
  }
}

class BottomTabNavBar extends StatelessWidget {
  const BottomTabNavBar(this._selectedIndex, this._onItemTapped, {super.key});

  final int _selectedIndex;
  final void Function(int) _onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _selectedIndex == 0
              ? const Svg('assets/svg/home-filled-nav.svg')
              : const Svg('assets/svg/home-nav.svg'),
          label: "HOME",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? const Svg('assets/svg/service-filled-nav.svg')
              : const Svg('assets/svg/service-nav.svg'),
          label: "SERVICES",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? const Svg('assets/svg/profile-filled-nav.svg')
              : const Svg('assets/svg/profile-nav.svg'),
          label: "PROFILE",
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3
              ? const Svg('assets/svg/setting-filled-nav.svg')
              : const Svg('assets/svg/setting-nav.svg'),
          label: "SETTINGS",
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
