import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:handees/data/user/models/user_db_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserLocalDataSource {
  final Future<Box> _userBoxFuture;

  UserLocalDataSource() : _userBoxFuture = Hive.openBox('user');

  Future<bool> get isDataStored async => (await _userBoxFuture).isNotEmpty;

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

    print('getting local ${userBox.get('name')}');

    try {
      return UserDbModel(
        name: userBox.get('name'),
        email: userBox.get('email'),
        phone: userBox.get('phone'),
      );
    } catch (e) {
      print('Error getting user $e');
      return null;
    }
  }

  Stream<UserDbModel> listenToUserData() {
    final controller = StreamController<UserDbModel>();

    var user = UserDbModel(name: '', email: '', phone: '');

    _userBoxFuture.then((box) {
      box.watch().listen((event) {
        print('Fetch events ${event.key} ${event.value}');
        final eventMap = {event.key: event.value};
        user = user.copyWith(
            name: eventMap['name'],
            email: eventMap['email'],
            phone: eventMap['phone']);
        controller.add(user);
      });
    });

    return controller.stream;
  }
}
