import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/models/base_url.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

class LoginController extends BaseController {
  Future<dynamic> handleLogin(String account, String password) async {
    showLoading();
    var response = await http.get(Uri.parse(
        "${BaseUrlAPI.baseUrl}/b92d89ca-2f3d-44cd-932c-957ccae17870"));
    Map<String, dynamic> authen = jsonDecode(response.body);
    AuthenModel dataLogin = AuthenModel.fromJson(authen);
    if (response.statusCode == 200) {
      if ((account == dataLogin.userName) && (password == dataLogin.password)) {
        StorageService.saveToken(tokenString: dataLogin.token);
        userName.value = dataLogin.userName.toString();
        hideLoading();
        RouterHelper.getOffUntil();
      } else {
        hideLoading();
        CustomSnackbar.snackBar('error', 'Sai tài khoản hoặc mật khẩu');
      }
    } else {
      debugPrintStack(label: 'error');
    }
  }

  void submitLogin() {
    if (userNameController.text == '' && passwordController.text == '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập tài khoản và mật khẩu');
    } else if (userNameController.text == '' && passwordController.text != '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập tài khoản');
    } else if (userNameController.text != '' && passwordController.text == '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập mật khẩu');
    } else {
      String account = userNameController.text;
      String password = passwordController.text;
      handleLogin(account, password);
    }
  }
}
