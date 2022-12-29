import 'package:get/instance_manager.dart';
import 'package:test_chart/controllers/languages/languages_controller.dart';
import 'package:test_chart/services/app_services.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguagesController(), permanent: true);
  }
}
