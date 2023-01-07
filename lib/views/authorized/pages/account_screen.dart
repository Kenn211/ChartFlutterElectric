import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/account/account_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';
import 'package:test_chart/views/authorized/widgets/text_field.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(title: 'profile'.tr, canBack: true),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imgAvatar,
                      fit: BoxFit.fill,
                      width: 100,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Nguyễn Việt Anh',
                        style: TextStyle(
                            color: AppColors.secondColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const TextFieldWidget(text: 'username'),
              const SizedBox(height: 10),
              const TextFieldWidget(
                text: 'username',
                inputPass: true,
              ),
              const SizedBox(height: 10),
              const TextFieldWidget(
                text: 'username',
                inputPass: true,
              ),
              const SizedBox(height: 30),
              Button(
                  text: 'updateinfo'.tr,
                  onTap: () {
                    controller.handleUpdateInfo();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
