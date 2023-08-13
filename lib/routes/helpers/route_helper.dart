import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core.dart';
import '../bindings/auth/login_binding.dart';
import '../bindings/home/home_binding.dart';

class RouterHelper {
  // ==================================== ROUTER ===========================================//

  RouterHelper._();
  static final prefs = SharedPreferences.getInstance();

  static void back() {
    Get.back();
  }

  static void toLogin() {
    Get.to(() => const LoginScreen(), binding: LoginBinding());
  }

  static void getOffUntil() {
    Get.offUntil(
        GetPageRoute(
            page: () => const HomePage(),
            transition: Transition.native,
            transitionDuration: const Duration(milliseconds: 250),
            binding: HomeBinding()),
        (route) => false);
  }

  static Future<void> getSelectCompany() async {
    Get.put(SelectCompanyController());

    await Future.delayed(
      const Duration(milliseconds: 200),
      () async {
        final select = Get.find<SelectCompanyController>();
        await Future.wait([select.fetchListCompany()]).whenComplete(() {
          Get.offUntil(
              GetPageRoute(
                page: () => const SelectCompanyScreen(),
              ),
              (route) => false);
        });
      },
    );
  }

  static Future<void> onLogout() async {
    final storage = await prefs;
    await storage.remove(Constants.isLogged);
    await storage.remove(Constants.refreshToken);
    await storage.remove(Constants.accessToken);
    await storage.remove(Constants.provinceCache);
    await storage.remove(Constants.salesLocationCache);
    await Get.offAndToNamed(Routes.login);
  }
}
