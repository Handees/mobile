import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/auth/providers/auth_provider.dart';
import 'package:handees/data/handees/job_category.dart';
import 'package:handees/data/user/models/user.dart';
import 'package:handees/services/user_data_service.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserModel>((ref) {
  return UserDataNotifier(ref.watch(userDataServiceProvider));
});

final categoryProvider = Provider<List<JobCategory>>((ref) {
  return jobCategories;
});

final userDataStatusProvider = Provider<SubmitStatus>((ref) {
  return ref.watch(authProvider.notifier).submitted;
});

class UserDataNotifier extends StateNotifier<UserModel> {
  UserDataNotifier(this._userDataService)
      : super(const UserModel(name: '', phone: '', email: '', addresses: [])) {
    refreshData();
  }

  final UserDataService _userDataService;

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String token,
  }) async {
    final result = await _userDataService.updateUserData(
        name: name, phone: phone, email: email, uid: uid, token: token);
    // if (result) {
    //   refreshData();
    // }
  }

  void refreshData() {
    // _userDataService.getUserData().then((value) => state = value);

    _userDataService.listentoUserData().listen((event) {
      state = event;
    });
  }
}
