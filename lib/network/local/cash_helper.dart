import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? sharedPreferences;

  static int() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> sendAppMod(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getAppMod({required String key}) {
    return sharedPreferences!.getBool(key);
  }
}
