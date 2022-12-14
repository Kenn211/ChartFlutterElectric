import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '/routes/app_routes.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  // static final prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // Get.offAndToNamed(Routes.login);
    Future.delayed(
        const Duration(seconds: 2), () => Get.offAndToNamed(Routes.login));
    // , () {
    //   handleCheckLogged();
    // }
    super.initState();
  }

  // Future<void> handleCheckLogged() async {
  //   final SharedPreferences storage = await prefs;
  //   final isLogged = storage.getString(Constants.accessToken);
  //   if (isLogged != null && isLogged.isNotEmpty) {
  //     FunctionHelper.refreshToken();
  //   } else {
  //     Get.offAndToNamed(Routes.login);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
