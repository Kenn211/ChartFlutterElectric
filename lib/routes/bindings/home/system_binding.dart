import 'package:get/get.dart';
import '../../../controllers/home/system_controller.dart';

class SystemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemController>(SystemController.new);
  }
}
