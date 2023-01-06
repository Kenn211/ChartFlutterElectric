import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/drawer/hydrological_controller.dart';
import 'package:test_chart/core.dart';

class HydrologicalScreen extends GetView<HydrologicalController> {
  const HydrologicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const AppBarCustom(
          canBack: true,
          title: 'Thủy văn',
        ),
      ),
    );
  }
}
