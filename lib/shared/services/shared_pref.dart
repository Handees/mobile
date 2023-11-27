import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs();

  static SharedPreferences? sharedPrefs;

  static Future<SharedPreferences?> getSharedPrefs() async {
    sharedPrefs ??= await SharedPreferences.getInstance();
    return sharedPrefs;
  }
}
