import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chart/controllers/auth/login_controller.dart';
import 'package:test_chart/services/storage/storage_service.dart';
import 'package:test_chart/shared/constants/local_images_path.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/views/unauthorized/register_screen.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                    'version 1.1'.tr,
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
                    'login'.toUpperCase(),
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

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//             margin: const EdgeInsets.only(top: 50),
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(Assets.imgLogin),
//                 const SizedBox(height: 10),
//                 Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   width: double.infinity,
//                   child: const Text(
//                     'version 1.1',
//                     textAlign: TextAlign.end,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   child: Text(
//                     'Thị trường điện'.toUpperCase(),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontSize: 22,
//                         color: Color.fromARGB(255, 63, 160, 239),
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   child: Text(
//                     'login'.toUpperCase(),
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 _FormLogin()
//               ],
//             )),
//       ),
//     );
//   }
// }

// Container _FormLogin(){

// }

// Container _FormLogin(BuildContext context) {
//   return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: GetBuilder<LoginController>(builder: (controller) {
//         bool showPassword = true;
//         return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           TextField(
//             controller: controller.userNameController,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Tên đăng nhập',
//             ),
//           ),
//           const SizedBox(height: 10),
//           Stack(
//             children: [
//               TextField(
//                 controller: controller.passwordController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'password',
//                 ),
//                 obscureText: showPassword,
//               ),
//               Positioned(
//                   top: 0,
//                   bottom: 0,
//                   right: 0,
//                   child: IconButton(
//                       focusColor: Colors.transparent,
//                       hoverColor: Colors.transparent,
//                       disabledColor: Colors.transparent,
//                       splashColor: Colors.transparent,
//                       highlightColor: Colors.transparent,
//                       onPressed: () {
//                         showPassword = !showPassword;
//                       },
//                       icon: showPassword == false
//                           ? const Icon(CupertinoIcons.eye_fill)
//                           : const Icon(CupertinoIcons.eye_slash_fill)))
//             ],
//           ),
//           const SizedBox(height: 10),
//           Container(
//             width: double.infinity,
//             child: const Text(
//               'Quên mật khẩu?',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 15,
//                   color: Color.fromARGB(255, 63, 160, 239),
//                   fontWeight: FontWeight.w400),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             width: double.infinity,
//             height: 50,
//             decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 63, 160, 239),
//                 borderRadius: const BorderRadius.all(Radius.circular(8)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                     offset: const Offset(0, 3), // changes position of shadow
//                   ),
//                 ]),
//             child: TextButton(
//                 child: Text(
//                   'login',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   // controller.submitLogin();
//                 }),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 child: const Text('Bạn không có tài khoản?'),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 15),
//                 child: TextButton(
//                   child: Text('register',
//                       style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.blue,
//                           fontWeight: FontWeight.w500)),
//                   onPressed: () {},
//                 ),
//               )
//             ],
//           )
//         ]);
//       }));
// }

class _FormLogin extends StatefulWidget {
  const _FormLogin({super.key});

  @override
  State<_FormLogin> createState() => __FormLoginState();
}

class __FormLoginState extends State<_FormLogin> {
  var controller = Get.put(LoginController());

  var showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: controller.userNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'user_login'.tr,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'password'.tr,
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
                  child: Text(
                    'login',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
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
                    child: Text('register',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500)),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        ));
  }
}
