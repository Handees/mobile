import 'package:flutter/material.dart';

import 'package:handees/res/icons.dart';

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
    icon: HandeeIcons.laundry,
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
    icon: HandeeIcons.housekeeping,
    foregroundColor: Color.fromRGBO(255, 161, 154, 1),
  );
  static const gardening = JobCategory._(
    name: "Gardening",
    id: "gardening",
    icon: HandeeIcons.gardening,
    foregroundColor: Color.fromRGBO(57, 186, 112, 1),
  );
  static const autoshop = JobCategory._(
    name: "Auto Shop",
    id: "autoshop",
    icon: HandeeIcons.autoshop,
    foregroundColor: Color.fromRGBO(80, 85, 92, 1),
  );
  static const barber = JobCategory._(
    name: "Barber",
    id: "barber",
    icon: HandeeIcons.barber,
    foregroundColor: Color.fromRGBO(230, 180, 27, 1),
  );
  static const hairStylist = JobCategory._(
    name: "Hair Stylist",
    id: "hair-stylist",
    icon: HandeeIcons.hair_brush,
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
  _JobCategories.barber,

  //repeated
  _JobCategories.autoshop,
  _JobCategories.carpentry,
  _JobCategories.gardening,
];
