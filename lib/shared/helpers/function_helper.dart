import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';
import 'package:test_chart/shared/app_shared.dart';

class FunctionHelper {
// Handle save token/refresh token
  // static final prefs = SharedPreferences.getInstance();
  // static Future<void> refreshToken() async {
  //   final SharedPreferences storage = await prefs;
  //   var refresh_token = await currentRefreshToken();
  //   if (refresh_token.isNotEmpty && refresh_token != 'null') {
  //     // await BaseClient.post(Constants.userRefreshToken, data: {
  //     //   'grant_type': 'refresh_token',
  //     //   'refresh_token': refresh_token,
  //     // }, headers: {
  //     //   'Accept': 'application/json',
  //     //   'Content-Type': 'application/x-www-form-urlencoded',
  //     // }, onSuccess: (response) {
  //     //   final data = LoginResponse.fromJson(response.data);
  //     //   if (data.access_token.isNotEmpty) {
  //     //     storage.setBool(Constants.isLogged, true);
  //     //     storage.setString(Constants.accessToken, data.access_token);
  //     //     storage.setString(Constants.refreshToken, data.refresh_token);
  //     //     RouterHelper.getOffUntil();
  //     //   } else {
  //     //     RouterHelper.onLogout();
  //     //   }
  //     // }, onError: (_) {
  //     //   RouterHelper.onLogout();
  //     // });
  //   }
  // }

  // // Get current token
  // static Future<String> currentRefreshToken() async {
  //   final SharedPreferences storage = await prefs;
  //   return storage.getString(Constants.refreshToken).toString();
  // }

  // // Get current token
  // static Future<String> currentToken() async {
  //   final SharedPreferences storage = await prefs;
  //   return storage.getString(Constants.accessToken).toString();
  // }

  static void showLoading([String? message]) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: message != null ? 150 : 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 1,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 10),
                Text(
                  message ?? '${'loading'.tr}...',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
    Future.delayed(const Duration(seconds: 30), () {
      hideLoading();
    });
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
