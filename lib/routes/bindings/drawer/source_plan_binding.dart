import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/source_plan_controller.dart';

class SourcePlanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SourcePlanController>(() => SourcePlanController());
  }
}
