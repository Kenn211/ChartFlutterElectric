import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class HomeController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    CustomSnackbar.showSuccessToast(
        'hello'.tr, 'Welcome to the Electric Market');
  }

  void handleChangeLang() {
    showLoading();
    Future.delayed(const Duration(seconds: 2), () async {
      LanguagesController().updateLocale('vi_VN');
      hideLoading();
    });
  }

  void handleLogout() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      RouterHelper.onLogout();
      hideLoading();
    });
  }
}
