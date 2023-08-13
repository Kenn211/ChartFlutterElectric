import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/biometric/biometric_auth.dart';
import '../../../../core.dart';

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
      floatingActionButton: IconButton(
        icon: const Icon(Icons.abc),
        onPressed: () async {
          final authenticate = await BiometricAuth().authenticate();
          if (authenticate) {
            print('đăng nhập thành công');
          }
        },
      ),
    );
  }
}
