import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/services/user_data_service.dart';

final nameProvider = StateNotifierProvider<NameStateNotifier, String>(
    (ref) => NameStateNotifier(UserDataService.instance));

class NameStateNotifier extends StateNotifier<String> {
  final UserDataService _userDataService;
  NameStateNotifier(this._userDataService) : super("") {
    _name = _userDataService.getName();
  }

  String _name = "";
  String get name => _name;
}

// _userDataService.listentoUserData().listen((event) {
    //   _name = event.name;
    //   notifyListeners();
    // });

// Future<void> updateUserData({
  //   required String name,
  //   required String phone,
  //   required String email,
  //   required String uid,
  //   required String token,
  // }) async {
  //   final result = await _userDataService.updateUserData(
  //       name: name, phone: phone, email: email, uid: uid, token: token);
  //   // if (result) {
  //   //   refreshData();
  //   // }
  // }

  // void refreshData() {
  //   _userDataService.getUserData().then((value) {
  //     _name = value.name;
  //     print('Got name ${name}');
  //     notifyListeners();
  //   });
  // }
