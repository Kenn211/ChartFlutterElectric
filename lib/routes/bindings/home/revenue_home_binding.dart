import 'package:get/get.dart';
import '../../../core.dart';

class RevenueHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RevenueHomeController>(RevenueHomeController.new);
  }
}
