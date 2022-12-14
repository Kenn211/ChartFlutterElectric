import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/routes/app_routes.dart';

class LoginController extends BaseController {
  void handleLogin(String account, String password) async {
    showLoading();
    await Future.delayed(const Duration(seconds: 3), () {
      if (account == 'a' && password == 'b') {
        Get.offAndToNamed(Routes.homePage);
        hideLoading();
      } else {
        hideLoading();
      }
    });
  }

  void submitLogin() {
    String account = userNameController.text;
    String password = passwordController.text;
    handleLogin(account, password);
  }
}
