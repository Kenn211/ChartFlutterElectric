import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class AccountController extends BaseController {
  void handleUpdateInfo() {
    showLoading();
    Future.delayed(const Duration(seconds: 2), () async {
      hideLoading();
      CustomSnackbar.showSuccessToast('success'.tr, 'updateinfo'.tr);
    });
  }
}
