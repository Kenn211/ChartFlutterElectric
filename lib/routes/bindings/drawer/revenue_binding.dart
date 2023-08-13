import 'package:get/get.dart';
import '../../../controllers/drawer/revenue_controller.dart';

class RevenueBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RevenueController>(RevenueController.new);
  }
}
