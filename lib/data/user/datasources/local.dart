import 'dart:io';

import 'package:handees/data/user/models/user_db_model.dart';
import 'package:hive/hive.dart';

class UserLocalDataSource {
  late Box userBox;

  UserLocalDataSource() {
    init();
  }

  Future<void> init() async {
    Hive.init(Directory.current.path);

    print('box exists ${await Hive.boxExists('user')}');
    if (await Hive.boxExists('user')) {
      userBox = await Hive.openBox('user');
    } else {
      userBox = await Hive.openBox('user');
    }
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
    if (userBox.isOpen) return null;

    return UserDbModel(
      name: userBox.get('name'),
      email: userBox.get('email'),
      phone: userBox.get('phone'),
    );
  }
}
