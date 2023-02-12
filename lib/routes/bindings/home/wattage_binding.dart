import 'package:get/get.dart';
import 'package:test_chart/controllers/app_controllers.dart';

class WattageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WattageController>(() => WattageController());
  }
}
