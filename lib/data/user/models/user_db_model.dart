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

  UserDbModel copyWith({
    required String? name,
    required String? email,
    required String? phone,
  }) =>
      UserDbModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
