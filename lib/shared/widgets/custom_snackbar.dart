import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_shared.dart';

class CustomSnackbar {
  static void snackBar(String type, String message) async {
    Get.snackbar(type == 'error' ? 'error'.tr : 'success'.tr, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        margin: const EdgeInsets.all(20));
  }

  static void showSuccessToast(String title, String message) async {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
