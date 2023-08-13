import 'package:get/get.dart';
import '../../../controllers/account/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(AccountController.new);
  }
}
