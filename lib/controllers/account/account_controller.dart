import '../../core.dart';
import '../base_controller.dart';

class AccountController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    showLoading();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataUser();
  }

  Future<void> fetchDataUser() async {
    final tokenSaved = await StorageService.getToken();
    await BaseClient.get(
      'https://mocki.io/v1/b92d89ca-2f3d-44cd-932c-957ccae17870',
      onSuccess: (response) {
        final authen = authenModelFromJson(response.data);
        if (authen!.data!.token == tokenSaved) {
          userName.value = authen.data!.userName.toString();
          oldPassword.value = authen.data!.password.toString();
        }
      },
    );
    hideLoading();
  }

  void submitChangePass() {
    final oldPass = oldPasswordController.text;
    final newPass = passwordController.text;
    final reNewPass = rePasswordController.text;
    if (oldPass != oldPassword.value) {
      CustomSnackbar.snackBar('error', 'Sai mật khẩu cũ');
    } else if (newPass != reNewPass) {
      CustomSnackbar.snackBar('error', 'Nhập lại nhập khẩu không đúng');
    } else {
      // handleChangePass(oldPass, newPass, reNewPass);
    }
  }

  // Future<void> handleChangePass(
  //     String oldPass, String newPass, String reNewPass) async {
  //   showLoading();
  //   try {
  //     await http.patch(Uri.parse(
  //         "https://mocki.io/v1/b92d89ca-2f3d-44cd-932c-957ccae17870"));
  //     hideLoading();
  //     oldPasswordController.clear();
  //     passwordController.clear();
  //     rePasswordController.clear();
  //     Get.back();
  //   } catch (e) {
  //     debugPrint('e');
  //   }
  // }
}
