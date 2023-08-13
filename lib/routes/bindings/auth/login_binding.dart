import 'package:get/instance_manager.dart';

import '/controllers/app_controllers.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(LoginController.new);
  }
}
