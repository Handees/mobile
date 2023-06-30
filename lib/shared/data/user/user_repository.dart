import 'package:handees/shared/data/user/datasources/remote.dart';

import 'models/api_user.model.dart';

class UserRepository {
  static UserRepository? _instance;

  UserRepository._();

  factory UserRepository() {
    return _instance ??= UserRepository._();
  }

  final _remote = UserRemoteDataSource();

  Future<ApiUserModel> fetchUserData(String token) {
    return _remote.fetchUserData(token);
  }

  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) {
    return _remote.submitUserData(
      name: name,
      phone: phone,
      email: email,
      uid: uid,
      token: token,
    );
  }

  Future<bool> submitArtisanData({
    required String uid,
    required int hourlyRate,
    required String jobCategory,
    required String jobTitle,
    required String token,
  }) {
    return _remote.submitArtisanData(
      uid: uid,
      hourlyRate: hourlyRate,
      jobCategory: jobCategory,
      jobTitle: jobTitle,
      token: token,
    );
  }

  Future<bool> updateUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) {
    return _remote.updateUserData(
      name: name,
      phone: phone,
      email: email,
      uid: uid,
      token: token,
    );
  }

  Future<dynamic> getArtisanData(String token) {
    return _remote.getArtisanData(token);
  }
}
