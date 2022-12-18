import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/home/system_controller.dart';
import 'package:test_chart/core.dart';

class SystemPage extends GetView<SystemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'system'.tr,
          canBack: true,
        ),
      ),
    );
  }
}
