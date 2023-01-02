import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

class HomeController extends BaseController {
  @override
  void onInit() async {}

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
