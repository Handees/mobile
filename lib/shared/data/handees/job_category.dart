import 'package:flutter/material.dart';

import 'package:handees/shared/res/icons.dart';

class JobCategory {
  final String name;
  final String id;
  final IconData icon;
  final Color foregroundColor;

  const JobCategory._({
    required this.name,
    required this.id,
    required this.icon,
    required this.foregroundColor,
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
    id: 'carpentary',
    icon: Icons.abc,
    foregroundColor: Colors.cyan,
  );
  static const hairStyling = JobCategory._(
    name: "Hair Styling",
    id: "hair styling",
    icon: HandeeIcons.hair_brush,
    foregroundColor: Color.fromRGBO(55, 61, 121, 1),
  );
  static const clothing = JobCategory._(
    name: "Clothing",
    id: "clothing",
    icon: Icons.checkroom,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  );
  static const plumbing = JobCategory._(
    name: "Plumbing",
    id: "plumbing",
    icon: Icons.plumbing,
    foregroundColor: Color.fromRGBO(15, 112, 52, 1),
  );
  static const automobile = JobCategory._(
    name: "Automobile",
    id: "automobile",
    icon: HandeeIcons.autoshop,
    foregroundColor: Color.fromRGBO(116, 197, 150, 1),
  );
  static const generatorRepair = JobCategory._(
    name: "Generator Repair",
    id: "generator repair",
    icon: Icons.home_repair_service,
    foregroundColor: Color.fromRGBO(80, 141, 68, 1),
  );
  static const tvCableEngineer = JobCategory._(
    name: "TV Cable Engineer",
    id: "tv cable engineer",
    icon: Icons.tv,
    foregroundColor: Color.fromRGBO(80, 85, 92, 1),
  );
  static const welding = JobCategory._(
    name: "Welding",
    id: "welding",
    icon: Icons.handyman,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  );
  static const housekeeping = JobCategory._(
    name: "Housekeeping",
    id: "house keeping",
    icon: HandeeIcons.housekeeping,
    foregroundColor: Color.fromRGBO(255, 161, 154, 1),
  );
  static const gardening = JobCategory._(
    name: "Gardening",
    id: "gardening",
    icon: HandeeIcons.gardening,
    foregroundColor: Color.fromRGBO(57, 186, 112, 1),
  );
}

//TODO: probably should be somewhere else
const jobCategories = [
  _JobCategories.laundry,
  _JobCategories.carpentry,
  _JobCategories.hairStyling,
  _JobCategories.clothing,
  _JobCategories.plumbing,
  _JobCategories.automobile,
  _JobCategories.generatorRepair,
  _JobCategories.tvCableEngineer,
  _JobCategories.welding,
  _JobCategories.gardening,
  _JobCategories.housekeeping,
];
