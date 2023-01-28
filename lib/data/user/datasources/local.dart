import 'package:handees/data/user/models/user_db_model.dart';
import 'package:hive/hive.dart';

class UserLocalDataSource {
  final Future<Box> _userBoxFuture;

  UserLocalDataSource() : _userBoxFuture = Hive.openBox('user');

  Future<void> storeUserData({
    required String name,
    required String phone,
    required String email,
  }) async {
    final userBox = await _userBoxFuture;
    userBox.putAll({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  Future<UserDbModel?> fetchUserData() async {
    final userBox = await _userBoxFuture;

    if (!userBox.isOpen) return null;

    print('getting local');

    return UserDbModel(
      name: userBox.get('name'),
      email: userBox.get('email'),
      phone: userBox.get('phone'),
    );
  }
}
