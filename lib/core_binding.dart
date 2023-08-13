import 'package:get/instance_manager.dart';
import 'controllers/languages/languages_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguagesController(), permanent: true);
  }
}
