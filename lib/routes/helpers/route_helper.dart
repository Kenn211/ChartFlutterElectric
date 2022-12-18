import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/controllers/auth/login_controller.dart';
import 'package:test_chart/routes/app_routes.dart';
import 'package:test_chart/shared/app_shared.dart';
import 'package:test_chart/views/authorized/pages/home_page.dart';
import 'package:test_chart/views/unauthorized/login_screen.dart';

class RouterHelper {
  // ==================================== ROUTER ===========================================//
  static final prefs = SharedPreferences.getInstance();

  static back() {
    Get.back();
  }

  static toLogin() {
    Get.to(() => const LoginScreen(), binding: BindingsBuilder(() {
      Get.put(LoginController());
    }));
  }

  static getOffUntil() {
    Get.offUntil(
        GetPageRoute(
          page: () => HomePage(),
          transition: Transition.native,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        (route) => false);
  }

  static onLogout() async {
    final SharedPreferences storage = await prefs;
    storage.remove(Constants.isLogged);
    storage.remove(Constants.refreshToken);
    storage.remove(Constants.accessToken);
    storage.remove(Constants.provinceCache);
    storage.remove(Constants.salesLocationCache);
    Get.offAndToNamed(Routes.login);
  }
}
