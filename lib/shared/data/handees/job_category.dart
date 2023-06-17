import 'package:flutter/material.dart';

import 'package:handees/shared/res/icons.dart';

enum JobCategory {
  laundry(
    name: 'Laundry',
    id: 'laundry',
    dbId: 1,
    icon: HandeeIcons.laundry,
    foregroundColor: Color.fromRGBO(65, 141, 244, 1),
  ),
  carpentry(
    name: 'Carpentry',
    id: 'carpentry',
    dbId: 2,
    icon: Icons.abc,
    foregroundColor: Colors.cyan,
  ),
  hairStyling(
    name: "Hair Styling",
    id: "hair styling",
    dbId: 3,
    icon: HandeeIcons.hair_brush,
    foregroundColor: Color.fromRGBO(55, 61, 121, 1),
  ),
  clothing(
    name: "Clothing",
    id: "clothing",
    dbId: 4,
    icon: Icons.checkroom,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  ),
  plumbing(
    name: "Plumbing",
    id: "plumbing",
    dbId: 5,
    icon: Icons.plumbing,
    foregroundColor: Color.fromRGBO(15, 112, 52, 1),
  ),
  automobile(
    name: "Automobile",
    id: "automobile",
    dbId: 6,
    icon: HandeeIcons.autoshop,
    foregroundColor: Color.fromRGBO(116, 197, 150, 1),
  ),
  generatorRepair(
    name: "Generator Repair",
    id: "generator repair",
    dbId: 7,
    icon: Icons.home_repair_service,
    foregroundColor: Color.fromRGBO(80, 141, 68, 1),
  ),
  tvCableEngineer(
    name: "TV Cable Engineer",
    id: "tv cable engineer",
    dbId: 8,
    icon: Icons.tv,
    foregroundColor: Color.fromRGBO(80, 85, 92, 1),
  ),
  welding(
    name: "Welding",
    id: "welding",
    dbId: 9,
    icon: Icons.handyman,
    foregroundColor: Color.fromRGBO(255, 125, 203, 1),
  ),
  gardening(
    name: "Gardening",
    id: "gardening",
    dbId: 10,
    icon: HandeeIcons.gardening,
    foregroundColor: Color.fromRGBO(57, 186, 112, 1),
  ),
  housekeeping(
    name: "Housekeeping",
    id: "house keeping",
    dbId: 11,
    icon: HandeeIcons.housekeeping,
    foregroundColor: Color.fromRGBO(255, 161, 154, 1),
  );

  const JobCategory({
    required this.name,
    required this.id,
    required this.dbId,
    required this.icon,
    required this.foregroundColor,
  });

  final String name;
  final String id;
  final int dbId;
  final IconData icon;
  final Color foregroundColor;
}
