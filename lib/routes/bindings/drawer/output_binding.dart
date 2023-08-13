import 'package:get/get.dart';
import '../../../controllers/drawer/output_controller.dart';

class OutputBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutputController>(OutputController.new);
  }
}
