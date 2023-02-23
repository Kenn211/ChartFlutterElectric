import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class RevenueHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RevenueHomeController>(() => RevenueHomeController());
  }
}
