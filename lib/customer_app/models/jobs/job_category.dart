import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class JobCategory {
  final String name;
  final String id;
  final IconData icon;
  // final Color backgroundColor;
  final Color foregroundColor;

  const JobCategory._({
    required this.name,
    required this.id,
    required this.icon,
    required this.foregroundColor,
    // required this.backgroundColor,
  });
}

abstract class _JobCategories {
  static const laundry = JobCategory._(
    name: 'Laundry',
    id: 'laundry',
    icon: Icons.abc,
    foregroundColor: Color.fromRGBO(65, 141, 244, 1),
  );
  static const carpentry = JobCategory._(
    name: 'Carpentry',
    id: 'capentry',
    icon: Icons.abc,
    foregroundColor: Colors.cyan,
  );
  static const housekeeping = JobCategory._(
    name: "Housekeeping",
    id: "housekeeping",
    icon: Icons.abc,
    foregroundColor: Color.fromRGBO(255, 161, 154, 1),
  );
  static const gardening = JobCategory._(
    name: "Gardening",
    id: "gardening",
    icon: Icons.alarm,
    foregroundColor: Color.fromRGBO(57, 186, 112, 1),
  );
  static const autoshop = JobCategory._(
    name: "Auto Shop",
    id: "autoshop",
    icon: Icons.ads_click,
    foregroundColor: Color.fromRGBO(80, 85, 92, 1),
  );
  static const barber = JobCategory._(
    name: "Barber",
    id: "barber",
    icon: Icons.baby_changing_station,
    foregroundColor: Color.fromRGBO(230, 180, 27, 1),
  );
  static const hairStylist = JobCategory._(
    name: "Hair Stylist",
    id: "hair-stylist",
    icon: Icons.hail_rounded,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  );
}

//TODO: probably should be somewhere else
const jobCategories = [
  _JobCategories.autoshop,
  _JobCategories.carpentry,
  _JobCategories.gardening,
  _JobCategories.hairStylist,
  _JobCategories.housekeeping,
  _JobCategories.laundry,
];
