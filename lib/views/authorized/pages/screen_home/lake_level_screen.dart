import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class LakeLevelScreen extends GetView<LakeLevelController> {
  const LakeLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'lake_level'.tr,
          canBack: true,
        ),
      ),
    );
  }
}
