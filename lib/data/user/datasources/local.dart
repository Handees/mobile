import 'dart:io';

import 'package:handees/data/user/models/user_db_model.dart';
import 'package:hive/hive.dart';

class UserLocalDataSource {
  late Box userBox;

  UserLocalDataSource() {
    init();
  }

  Future<void> init() async {
    userBox = await Hive.openBox('user');
  }

  void storeUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    userBox.putAll({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  UserDbModel? fetchUserData() {
    print('FEtching  local is open ${userBox.isOpen}');

    if (!userBox.isOpen) return null;

    print('getting local');

    return UserDbModel(
      name: userBox.get('name'),
      email: userBox.get('email'),
      phone: userBox.get('phone'),
    );
  }
}
