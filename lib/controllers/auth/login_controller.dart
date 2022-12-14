import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_chart/routes/app_routes.dart';
import 'package:test_chart/shared/helpers/function_helper.dart';

class LoginController extends GetxController {
  final _userNameController = TextEditingController();
  TextEditingController get userNameController => _userNameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  void handleLogin(String account, String password) {
    showLoading();
    Future.delayed(const Duration(seconds: 3), () {
      if (account == 'a' && password == 'b') {
        Get.offAndToNamed(Routes.homePage);
        hideLoading();
      }
    });
  }

  void showLoading() {
    FunctionHelper.showLoading();
  }

  void hideLoading() {
    FunctionHelper.hideLoading();
  }

  void submitLogin() {
    String account = userNameController.text;
    String password = passwordController.text;
    handleLogin(account, password);
  }
}
