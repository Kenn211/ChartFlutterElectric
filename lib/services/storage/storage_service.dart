import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/controllers/check_network/check_network_controller.dart';

import '/shared/constants/keys.dart';

class StorageService extends GetxService {
  final prefs = SharedPreferences.getInstance();
  late String languageCode;
  late String countryCode;

  Future<StorageService> init() async {
    final SharedPreferences storage = await prefs;
    languageCode = storage.getString(Constants.languageCode) ?? 'vi';
    countryCode = storage.getString(Constants.countryCode) ?? 'VN';
    return this;
  }

  void initConnect() {
    Get.put<CheckNetWorkController>(CheckNetWorkController(), permanent: true);
  }

  static void saveToken({String? tokenString}) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, tokenString!);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.accessToken);
  }

  void write(String key, dynamic value) async {
    final SharedPreferences storage = await prefs;
    if (value is bool) {
      storage.setBool(key, value);
    } else if (value is String) {
      storage.setString(key, value);
    } else if (value is int) {
      storage.setInt(key, value);
    } else if (value is List<String>) {
      storage.setStringList(key, value);
    }
  }

  void remove(String key) async {
    final SharedPreferences storage = await prefs;
    storage.remove(key);
    storage.reload();
  }
}
