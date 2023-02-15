import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: const EdgeInsets.only(top: 50),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Assets.imgLogin),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: double.infinity,
                  child: Text(
                    '${'version'.tr} 1.1',
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'title_app'.tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 63, 160, 239),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'login'.tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const _FormLogin()
              ],
            )),
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
                height: 50,
                child: TextFieldWidget(
                  actionInput: TextInputAction.next,
                  inputPass: false,
                  text: 'user_login'.tr,
                  TextController: controller.userNameController,
                )),
            const SizedBox(height: 20),

            SizedBox(
                height: 50,
                child: TextFieldWidget(
                  actionInput: TextInputAction.done,
                  inputPass: true,
                  obscurText: true,
                  text: 'password'.tr,
                  TextController: controller.passwordController,
                )),
            const SizedBox(height: 10),

            // const SizedBox(height: 10),
            // const SizedBox(
            //   width: double.infinity,
            //   child: Text(
            //     'Quên mật khẩu?',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         fontSize: 15,
            //         color: Color.fromARGB(255, 63, 160, 239),
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Button(
                  text: 'login'.tr.toUpperCase(),
                  showIcon: false,
                  onTap: controller.submitLogin),
            ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     const SizedBox(
            //       child: Text('Bạn không có tài khoản?'),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.only(left: 15),
            //       child: TextButton(
            //         child: Text('register'.tr,
            //             style: const TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.blue,
            //                 fontWeight: FontWeight.w500)),
            //         onPressed: () {
            //           Get.toNamed(Routes.register);
            //         },
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      );
    });
  }
}
