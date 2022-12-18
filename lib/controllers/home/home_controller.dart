import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class HomeController extends BaseController {
  void handleChangeLang() {
    showLoading();
    Future.delayed(const Duration(seconds: 2), () async {
      LanguagesController().updateLocale('en_US');
      hideLoading();
    });
  }

  void handleLogout() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      StorageService().remove(Constants.accessToken);
      Get.offAndToNamed(Routes.login);
      hideLoading();
    });
  }
}
