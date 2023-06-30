import 'package:flutter/material.dart';

import 'package:handees/shared/res/icons.dart';

class JobCategory {
  final String name;
  final String id;
  final int dbId;
  final IconData icon;
  final Color foregroundColor;

  const JobCategory._({
    required this.name,
    required this.id,
    required this.dbId,
    required this.icon,
    required this.foregroundColor,
  });
}

abstract class _JobCategories {
  static const laundry = JobCategory._(
    name: 'Laundry',
    id: 'laundry',
    dbId: 1,
    icon: HandeeIcons.laundry,
    foregroundColor: Color.fromRGBO(65, 141, 244, 1),
  );
  static const carpentry = JobCategory._(
    name: 'Carpentry',
    id: 'carpentry',
    dbId: 2,
    icon: Icons.abc,
    foregroundColor: Colors.cyan,
  );
  static const hairStyling = JobCategory._(
    name: "Hair Styling",
    id: "hair styling",
    dbId: 3,
    icon: HandeeIcons.hairBrush,
    foregroundColor: Color.fromRGBO(55, 61, 121, 1),
  );
  static const clothing = JobCategory._(
    name: "Clothing",
    id: "clothing",
    dbId: 4,
    icon: Icons.checkroom,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  );
  static const plumbing = JobCategory._(
    name: "Plumbing",
    id: "plumbing",
    dbId: 5,
    icon: Icons.plumbing,
    foregroundColor: Color.fromRGBO(15, 112, 52, 1),
  );
  static const automobile = JobCategory._(
    name: "Automobile",
    id: "automobile",
    dbId: 6,
    icon: HandeeIcons.autoshop,
    foregroundColor: Color.fromRGBO(116, 197, 150, 1),
  );
  static const generatorRepair = JobCategory._(
    name: "Generator Repair",
    id: "generator repair",
    dbId: 7,
    icon: Icons.home_repair_service,
    foregroundColor: Color.fromRGBO(80, 141, 68, 1),
  );
  static const tvCableEngineer = JobCategory._(
    name: "TV Cable Engineer",
    id: "tv cable engineer",
    dbId: 8,
    icon: Icons.tv,
    foregroundColor: Color.fromRGBO(80, 85, 92, 1),
  );
  static const welding = JobCategory._(
    name: "Welding",
    id: "welding",
    dbId: 9,
    icon: Icons.handyman,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  );
  static const gardening = JobCategory._(
    name: "Gardening",
    id: "gardening",
    dbId: 10,
    icon: HandeeIcons.gardening,
    foregroundColor: Color.fromRGBO(57, 186, 112, 1),
  );
  static const housekeeping = JobCategory._(
    name: "Housekeeping",
    id: "house keeping",
    dbId: 11,
    icon: HandeeIcons.housekeeping,
    foregroundColor: Color.fromRGBO(255, 161, 154, 1),
  );
}

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

const jobCategoriesMap = {
  1: _JobCategories.laundry,
  2: _JobCategories.carpentry,
  3: _JobCategories.hairStyling,
  4: _JobCategories.clothing,
  5: _JobCategories.plumbing,
  6: _JobCategories.automobile,
  7: _JobCategories.generatorRepair,
  8: _JobCategories.tvCableEngineer,
  9: _JobCategories.welding,
  10: _JobCategories.gardening,
  11: _JobCategories.housekeeping,
};
