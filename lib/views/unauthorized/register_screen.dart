import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/auth/register_controller.dart';
import 'package:test_chart/shared/constants/local_images_path.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: const EdgeInsets.only(top: 50),
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
                    'register'.tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                _FormRegister(
                  register: () {
                    controller.handleRegister();
                  },
                )
              ],
            )),
      ),
    );
  }
}

class _FormRegister extends StatefulWidget {
  const _FormRegister({super.key, this.register});

  final Function()? register;

  @override
  State<_FormRegister> createState() => __FormRegisterState();
}

class __FormRegisterState extends State<_FormRegister> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passConfirmController = TextEditingController();

  var showPassword = true;
  var showConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'user_login'.tr,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    labelText: 'password'.tr,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  obscureText: showPassword,
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
            const SizedBox(height: 10),
            Stack(
              children: [
                TextField(
                  controller: passConfirmController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    labelText: '${'confirm'.tr} ${'password'.tr.toLowerCase()}',
                  ),
                  obscureText: showConfirmPass,
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
                            showConfirmPass = !showConfirmPass;
                          });
                        },
                        icon: showConfirmPass == false
                            ? const Icon(CupertinoIcons.eye_fill)
                            : const Icon(CupertinoIcons.eye_slash_fill)))
              ],
            ),
            const SizedBox(height: 10),
            Container(
                height: 50,
                child: Button(
                    showIcon: false,
                    text: 'register'.tr.toUpperCase(),
                    onTap: () {
                      widget.register;
                    })),
          ],
        ));
  }
}
