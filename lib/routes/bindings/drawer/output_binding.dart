import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/output_controller.dart';

class OutputBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutputController>(() => OutputController());
  }
}
