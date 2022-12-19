import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/tonnage_controller.dart';

class TonnageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TonnageController>(() => TonnageController());
  }
}
