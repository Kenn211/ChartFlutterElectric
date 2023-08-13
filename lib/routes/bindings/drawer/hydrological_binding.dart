import 'package:get/get.dart';
import '../../../controllers/drawer/hydrological_controller.dart';

class HydrologicalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HydrologicalController>(HydrologicalController.new);
  }
}
