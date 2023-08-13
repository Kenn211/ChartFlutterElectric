import 'package:get/get.dart';
import '../../../controllers/drawer/marginal_price_controller.dart';

class MarginalPriceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarginalPriceController>(MarginalPriceController.new);
  }
}
