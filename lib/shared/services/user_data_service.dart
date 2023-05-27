import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:handees/shared/data/user/models/api_user.model.dart';
import 'package:handees/shared/data/user/user_repository.dart';
import 'package:handees/shared/res/uri.dart';
import 'package:handees/shared/services/auth_service.dart';

import 'package:http/http.dart' as http;

class UserDataService {
  final AuthService authService;
  final UserRepository userRepository;
  UserDataService._(this.userRepository, this.authService);

  static final instance =
      UserDataService._(UserRepository(), AuthService.instance);

  bool _doesUserExist = false;

  bool get doesUserExist => _doesUserExist;

  Future<ApiUserModel?> getUser() async {
    try {
      if (!authService.doesTokenExist()) {
        await authService.getToken();
      }

      final user = await userRepository.fetchUserData(authService.token);
      _doesUserExist = true;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> submitUser() async {
    try {
      final user = AuthService.instance.user;
      final isUserSubmitted = await userRepository.submitUserData(
          name: user.displayName!,
          phone: user.phoneNumber ?? "080756",
          email: user.email!,
          uid: user.uid,
          token: AuthService.instance.token);
      return isUserSubmitted;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
