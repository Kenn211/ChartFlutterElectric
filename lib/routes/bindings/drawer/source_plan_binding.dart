import 'package:get/get.dart';
import '../../../controllers/drawer/source_plan_controller.dart';

class SourcePlanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SourcePlanController>(SourcePlanController.new);
  }
}
