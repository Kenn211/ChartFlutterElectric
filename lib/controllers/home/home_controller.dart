import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

class HomeController extends BaseController {
  void handleLogout() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      RouterHelper.onLogout();
      hideLoading();
    });
  }
}
