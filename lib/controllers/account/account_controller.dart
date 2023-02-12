import 'package:flutter/cupertino.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AccountController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    showLoading();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataUser();
  }

  Future<void> fetchDataUser() async {
    final tokenSaved = await StorageService.getToken();
    try {
      await BaseClient()
          .get('https://mocki.io/v1/b92d89ca-2f3d-44cd-932c-957ccae17870')
          .then((value) {
        AuthenModel? authen = authenModelFromJson(value.body);
        if (authen!.data!.token == tokenSaved) {
          userName.value = authen.data!.userName.toString();
          oldPassword.value = authen.data!.password.toString();
        }
      });
      hideLoading();
    } catch (e) {
      debugPrint('e');
    }
  }

  void submitChangePass() {
    String oldPass = oldPasswordController.text;
    String newPass = passwordController.text;
    String reNewPass = rePasswordController.text;
    if (oldPass != oldPassword.value) {
      CustomSnackbar.snackBar('error', 'Sai mật khẩu cũ');
    } else if (newPass != reNewPass) {
      CustomSnackbar.snackBar('error', 'Nhập lại nhập khẩu không đúng');
    } else {
      handleChangePass(oldPass, newPass, reNewPass);
    }
  }

  Future<void> handleChangePass(
      String oldPass, String newPass, String reNewPass) async {
    showLoading();
    try {
      await http.patch(Uri.parse(
          "https://mocki.io/v1/b92d89ca-2f3d-44cd-932c-957ccae17870"));
      hideLoading();
      oldPasswordController.clear();
      passwordController.clear();
      rePasswordController.clear();
      Get.back();
    } catch (e) {
      debugPrint('e');
    }
  }
}
