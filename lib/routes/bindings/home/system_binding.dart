import 'package:get/get.dart';
import 'package:test_chart/controllers/home/system_controller.dart';

class SystemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemController>(() => SystemController());
  }
}
