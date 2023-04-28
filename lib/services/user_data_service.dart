import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/user/models/user.dart';
import 'package:handees/data/user/user_repository.dart';
import 'package:handees/res/uri.dart';

import 'package:http/http.dart' as http;

class UserDataService {
  UserDataService._(this.userRepository, this.firebaseAuth);

  static final instance =
      UserDataService._(UserRepository(), FirebaseAuth.instance);

  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;

  // Future<bool> updateUserData({
  //   required String name,
  //   required String phone,
  //   required String email,
  //   required String uid,
  //   required String token,
  // }) async {
  //   return userRepository.updateUserData(
  //       name: name, phone: phone, email: email, uid: uid, token: token);
  // }

  Future<bool> dataSubmitted() async {
    // if (await userRepository.local.isDataStored) return true;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      final response = await http.get(
        AppUris.userDataUri(user.uid),
      );

      return response.statusCode != 404;
    } on Exception catch (e) {
      debugPrint('Data submit error $e');
      return false;
    }
  }

  // Future<UserModel> getUserData() => userRepository.fetchUserData();

  // Stream<UserModel> listentoUserData() => userRepository.listenToUserData();
}
