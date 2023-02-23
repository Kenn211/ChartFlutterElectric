import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class LakeLevelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LakeLevelController>(() => LakeLevelController());
  }
}
