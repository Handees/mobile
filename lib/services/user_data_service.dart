import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/data/user/models/user.dart';
import 'package:handees/data/user/user_repository.dart';

final userDataServiceProvider = Provider<UserDataService>((ref) {
  return UserDataService._(UserRepository());
});

class UserDataService {
  UserDataService._(this.userRepository);

  final UserRepository userRepository;

  Future<bool> updateUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    return userRepository.updateUserData(
        name: name, phone: phone, email: email, uid: uid, token: token);
  }

  Future<UserModel> getUserData() => userRepository.fetchUserData();

  Stream<UserModel> listentoUserData() => userRepository.listenToUserData();
}
