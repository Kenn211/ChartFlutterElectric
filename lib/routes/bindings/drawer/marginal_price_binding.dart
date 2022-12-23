import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';

class MarginalPriceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarginalPriceController>(() => MarginalPriceController());
  }
}
