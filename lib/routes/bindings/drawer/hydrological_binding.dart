import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/hydrological_controller.dart';

class HydrologicalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HydrologicalController>(() => HydrologicalController());
  }
}
