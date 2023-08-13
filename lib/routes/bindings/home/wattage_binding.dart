import 'package:get/get.dart';
import '../../../controllers/app_controllers.dart';

class WattageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WattageController>(WattageController.new);
  }
}
