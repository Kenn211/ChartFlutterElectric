import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core.dart';
import '../../routes/helpers/route_helper.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  final prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), handleCheckLogged);
    super.initState();
  }

  Future<void> handleCheckLogged() async {
    final storage = await prefs;
    final isLogged = storage.getString(Constants.accessToken);
    if (isLogged != null && isLogged.isNotEmpty) {
      await RouterHelper.getSelectCompany();
    } else {
      RouterHelper.toLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
