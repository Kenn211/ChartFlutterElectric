import 'package:get/get.dart';
import '../../../controllers/drawer/tonnage_controller.dart';

class TonnageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TonnageController>(TonnageController.new);
  }
}
