import 'package:flutter/cupertino.dart';

@immutable
class UserDbModel {
  final String name;
  final String phone;
  final String email;

  const UserDbModel({
    required this.name,
    required this.email,
    required this.phone,
  });
}
