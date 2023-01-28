import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:handees/data/user/datasources/local.dart';
import 'package:handees/data/user/datasources/remote.dart';
import 'package:handees/data/user/models/user.dart';

class UserRepository {
  static UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() {
    return _instance;
  }

  final remote = UserRemoteDataSource();
  final local = UserLocalDataSource();

  Future<User> fetchUserData() async {
    await Future.delayed(Duration(seconds: 10));
    final localData = local.fetchUserData();

    if (localData != null) {
      print('From local');
      return User(name: localData.name);
    } else {
      final remoteData = await remote
          .fetchUserData(firebase.FirebaseAuth.instance.currentUser!.uid);
      local.storeUserData(
          email: remoteData.email, name: remoteData.name, phone: '1234');
      print('From remote');
      return User(name: remoteData.name);
    }
  }

  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) =>
      remote.submitUserData(
          name: name, phone: phone, email: email, uid: uid, token: token);

  Future<void> saveUserData() => throw UnimplementedError();
}
