import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core.dart';

class RevenueHome extends GetView<RevenueHomeController> {
  const RevenueHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'revenue'.tr,
          canBack: true,
        ),
      ),
    );
  }
}
