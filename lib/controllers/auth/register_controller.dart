import 'package:test_chart/controllers/base_controller.dart';
import 'package:http/http.dart' as http;

class RegisterController extends BaseController {
  void handleRegister() {
    showLoading();
    Future.delayed(const Duration(seconds: 3), () {
      hideLoading();
    });
  }
}
