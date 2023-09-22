import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/shared/data/user/models/api_user.model.dart';
import 'package:handees/shared/services/user_data_service.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, ApiUserModel>(
    (ref) => UserStateNotifier(UserDataService.instance));

class UserStateNotifier extends StateNotifier<ApiUserModel> {
  final UserDataService _userDataService;
  UserStateNotifier(this._userDataService) : super(ApiUserModel.empty());

  Future<void> getUserObject() async {
    final user = await _userDataService.getUser();
    if (user != null) {
      state = user;
    }
  }

  void updateKycStatus(String kycStatus) {
    if (state.artisanProfile != null) {
      state = state.copyWith(
        artisanProfile: state.artisanProfile!.copyWith(
          kycStatus: kycStatus,
        ),
      );
    }
  }
}
