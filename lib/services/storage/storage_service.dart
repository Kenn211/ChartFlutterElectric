import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/shared/constants/keys.dart';

class StorageService extends GetxService {
  final prefs = SharedPreferences.getInstance();
  late String languageCode;
  late String countryCode;

  Future<StorageService> init() async {
    final storage = await prefs;
    languageCode = storage.getString(Constants.languageCode) ?? 'vi';
    countryCode = storage.getString(Constants.countryCode) ?? 'VN';
    return this;
  }

  static Future<void> saveToken({String? tokenString}) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessToken, tokenString!);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.accessToken);
  }

  // ignore: type_annotate_public_apis
  Future<void> write(String key, value) async {
    final storage = await prefs;
    if (value is bool) {
      await storage.setBool(key, value);
    } else if (value is String) {
      await storage.setString(key, value);
    } else if (value is int) {
      await storage.setInt(key, value);
    } else if (value is List<String>) {
      await storage.setStringList(key, value);
    }
  }

  Future<void> remove(String key) async {
    final storage = await prefs;
    await storage.remove(key);
    await storage.reload();
  }
}
