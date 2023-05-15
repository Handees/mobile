import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:handees/data/user/datasources/local.dart';
import 'package:handees/data/user/datasources/remote.dart';
import 'package:handees/data/user/models/user.dart';

class UserRepository {
  static UserRepository? _instance;

  UserRepository._();

  factory UserRepository() {
    return _instance ??= UserRepository._();
  }

  final remote = UserRemoteDataSource();
  final local = UserLocalDataSource();

  Future<bool> localDataExitst() => local.isDataStored;

  Future<UserModel> fetchUserData() async {
    var localData = await local.fetchUserData();
    await refreshData();

    localData ??= await local.fetchUserData();

    return UserModel(
      name: localData!.name,
      addresses: const [],
      email: localData.email,
      phone: localData.phone,
    );
  }

  Stream<UserModel> listenToUserData() =>
      local.listenToUserData().map((model) => UserModel(
            name: model.name,
            phone: model.phone,
            email: model.email,
            addresses: const [],
          ));

  Future<void> refreshData() async {
    final remoteData = await remote
        .fetchUserData(firebase.FirebaseAuth.instance.currentUser!.uid);

    print('Did refresh email is ${remoteData.email}');
    await local.storeUserData(
        email: remoteData.email,
        name: remoteData.name,
        phone: firebase.FirebaseAuth.instance.currentUser!.phoneNumber!);
  }

  Future<bool> submitUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    final result = await remote.submitUserData(
        name: name, phone: phone, email: email, uid: uid, token: token);

    if (result) local.storeUserData(name: name, phone: phone, email: email);

    return result;
  }

  Future<bool> updateUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    final result = await remote.updateUserData(
        name: name, phone: phone, email: email, uid: uid, token: token);

    print('Since $result store $email');

    if (result) local.storeUserData(name: name, phone: phone, email: email);

    return result;
  }
}
