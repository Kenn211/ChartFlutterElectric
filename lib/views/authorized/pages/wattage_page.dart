import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class WattagePage extends GetView<WattageController> {
  const WattagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'Công suất'.tr,
          canBack: true,
        ),
      ),
    );
  }
}
