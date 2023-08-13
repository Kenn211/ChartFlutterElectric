import 'package:get/get.dart';

import '../../../controllers/home/output_home_controller.dart';

class OutputHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutputHomeController>(OutputHomeController.new);
  }
}
