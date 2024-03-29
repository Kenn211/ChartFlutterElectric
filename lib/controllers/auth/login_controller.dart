import '../../core.dart';
import '../../routes/helpers/route_helper.dart';
import '../base_controller.dart';

class LoginController extends BaseController {
  Future<void> handleLogin(String account, String password) async {
    showLoading();
    await BaseClient.get(
        'https://mocki.io/v1/b92d89ca-2f3d-44cd-932c-957ccae17870',
        onSuccess: (response) {
      final authen = authenModelFromJson(response.data);
      if ((account == authen!.data!.userName) &&
          (password == authen.data!.password)) {
        StorageService.saveToken(tokenString: authen.data!.token);
        userName.value = authen.data!.userName.toString();
        RouterHelper.getSelectCompany();
      } else {
        hideLoading();
        CustomSnackbar.snackBar('error', 'Sai tài khoản hoặc mật khẩu');
      }
    });
  }

  void submitLogin() {
    if (userNameController.text == '' && passwordController.text == '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập tài khoản và mật khẩu');
    } else if (userNameController.text == '' && passwordController.text != '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập tài khoản');
    } else if (userNameController.text != '' && passwordController.text == '') {
      CustomSnackbar.snackBar('error', 'Vui lòng nhập mật khẩu');
    } else {
      final account = userNameController.text;
      final password = passwordController.text;
      handleLogin(account, password);
    }
  }
}
