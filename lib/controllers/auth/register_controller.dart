import '../base_controller.dart';

class RegisterController extends BaseController {
  void handleRegister() {
    showLoading();
    Future.delayed(const Duration(seconds: 3), hideLoading);
  }
}
