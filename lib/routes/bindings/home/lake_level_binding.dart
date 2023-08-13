import 'package:get/get.dart';

import '../../../controllers/home/lake_level_controller.dart';

class LakeLevelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LakeLevelController>(LakeLevelController.new);
  }
}
