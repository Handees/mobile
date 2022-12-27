import 'package:flutter/material.dart';
import 'package:handees/customer_app/features/home/ui/service_card.dart';

class ServiceType {
  final String name;
  // final Color backgroundColor;
  // final Color foregroundColor;
  // final Icon icon;

  const ServiceType._({
    required this.name,
    // required this.icon,
    // required this.foregroundColor,
    // required this.backgroundColor,
  });
}

abstract class ServiceTypes {
  static const laundry = ServiceType._(name: 'Laundry');
}
