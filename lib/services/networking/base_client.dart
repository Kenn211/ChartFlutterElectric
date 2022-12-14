import 'package:shared_preferences/shared_preferences.dart';

class BaseClient {
  static final prefs = SharedPreferences.getInstance();
  static const int TIME_OUT_DURATION = 30000;

  BaseClient() {}
}
