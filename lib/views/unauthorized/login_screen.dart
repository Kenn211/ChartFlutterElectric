import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chart/controllers/auth/login_controller.dart';
import 'package:test_chart/routes/app_routes.dart';
import 'package:test_chart/shared/constants/local_images_path.dart';
import 'package:get/get.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

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
                Container(
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
                Container(
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
                _FormLogin()
              ],
            )),
      ),
    );
  }
}

class _FormLogin extends StatefulWidget {
  const _FormLogin({super.key});

  @override
  State<_FormLogin> createState() => __FormLoginState();
}

class __FormLoginState extends State<_FormLogin> {
  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showPassword = true;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: TextField(
              controller: controller.userNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'user_login'.tr,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: Stack(
              children: [
                Container(
                  child: TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'password'.tr,
                    ),
                    obscureText: showPassword,
                  ),
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword == false
                            ? const Icon(CupertinoIcons.eye_fill)
                            : const Icon(CupertinoIcons.eye_slash_fill)))
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: const Text(
              'Quên mật khẩu?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 63, 160, 239),
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            child: Button(
                text: 'login'.tr.toUpperCase(),
                showIcon: false,
                onTap: () {
                  controller.submitLogin();
                }),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text('Bạn không có tài khoản?'),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: TextButton(
                  child: Text('register'.tr,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Get.toNamed(Routes.register);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
