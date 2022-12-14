import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chart/shared/constants/local_images_path.dart';

class RegisterScreen extends StatelessWidget {
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
                  child: const Text(
                    'version 1.1',
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Thị trường điện'.toUpperCase(),
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
                    'Đăng ký'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const _FormRegister()
              ],
            )),
      ),
    );
  }
}

class _FormRegister extends StatefulWidget {
  const _FormRegister({super.key});

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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tên đăng nhập',
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                TextField(
                  controller: passController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mật khẩu',
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Xác nhận mật khẩu',
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
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 160, 239),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: TextButton(
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
