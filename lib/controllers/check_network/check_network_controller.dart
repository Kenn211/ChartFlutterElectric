import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:test_chart/core.dart';

class CheckNetWorkController extends GetxController {
  final Connectivity connectivity = Connectivity();

  late ConnectivityResult connectivityResult;

  late StreamSubscription<ConnectivityResult> streamSubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    streamSubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    connectivityResult = await connectivity.checkConnectivity();

    updateConnectionStatus(connectivityResult);
  }

  void updateConnectionStatus(ConnectivityResult connectionActivity) {
    if (connectionActivity == ConnectivityResult.none) {
      CustomSnackbar.snackBar('error', 'Không có kết nối internet');
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    streamSubscription.cancel();
  }
}
