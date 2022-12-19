import 'package:get/get.dart';
import 'package:test_chart/controllers/account/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
