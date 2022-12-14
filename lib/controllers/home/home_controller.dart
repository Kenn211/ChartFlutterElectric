import 'package:test_chart/controllers/base_controller.dart';

class HomeController extends BaseController {
  void handleChangLang() {
    showLoading();
    Future.delayed(const Duration(seconds: 2), () {
      hideLoading();
    });
  }
}
