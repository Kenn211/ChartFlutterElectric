import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/revenue_controller.dart';

class RevenueBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RevenueController>(() => RevenueController());
  }
}
