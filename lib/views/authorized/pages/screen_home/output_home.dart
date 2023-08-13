import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core.dart';

class OutputHome extends GetView<OutputHomeController> {
  const OutputHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'output'.tr,
          canBack: true,
        ),
      ),
    );
  }
}
