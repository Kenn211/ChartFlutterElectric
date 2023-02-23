import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class OutputHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutputHomeController>(() => OutputHomeController());
  }
}
