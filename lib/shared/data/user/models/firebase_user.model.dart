import 'package:flutter/cupertino.dart';

@immutable
class FirebaseUserModel {
  final String name;
  final String phone;
  final String email;

  const FirebaseUserModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  FirebaseUserModel copyWith({
    required String? name,
    required String? email,
    required String? phone,
  }) =>
      FirebaseUserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );
}
