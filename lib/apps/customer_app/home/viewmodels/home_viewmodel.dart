import 'package:flutter/foundation.dart';
import 'package:handees/data/handees/job_category.dart';
import 'package:handees/services/user_data_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._userDataService) {
    // refreshData();

    // _userDataService.listentoUserData().listen((event) {
    //   _name = event.name;
    //   notifyListeners();
    // });
  }
  final UserDataService _userDataService;

  String _name = '';
  String get name => _name;

  List get ongoingHandee => throw UnimplementedError();

  List<JobCategory> get categories => jobCategories;

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
}
