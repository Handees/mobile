import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String phone;
  final String email;

  final List<String> addresses;

  const UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.addresses,
  });
}
