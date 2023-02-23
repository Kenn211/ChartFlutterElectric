import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

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
                        child: Obx(
                          () => Text(
                            controller.userName.toString(),
                            style: TextStyle(
                                color: AppColors.secondColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () => _InfoUser(
                  title: 'Tên đăng nhập: ',
                  description: controller.userName.toString(),
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () => _InfoUser(
                  title: 'Mật khẩu: ',
                  description: controller.oldPassword.toString(),
                ),
              ),
              const SizedBox(height: 10),
              const BottomSheetExample()
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoUser extends StatelessWidget {
  const _InfoUser({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.black),
      )),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 20),
          SizedBox(
            child: Text(description,
                style: TextStyle(fontSize: 16, color: AppColors.secondColor)),
          )
        ],
      ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 63, 160, 239),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          child: const Text('Đổi mật khẩu'),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: 800,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: KeyboardActions(
                        config: controller.buildKeyboardActionsConfig(context),
                        child: ListView(
                          children: <Widget>[
                            const Text(
                              'Đổi mật khẩu',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                                height: 50,
                                child: TextFieldWidget(
                                  focusNode: controller.oldPassFocus,
                                  actionInput: TextInputAction.next,
                                  inputPass: true,
                                  text: 'Mật khẩu',
                                  TextController:
                                      controller.oldPasswordController,
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                                height: 50,
                                child: TextFieldWidget(
                                  focusNode: controller.newPassFocus,
                                  actionInput: TextInputAction.next,
                                  inputPass: true,
                                  text: 'Mật khẩu mới',
                                  TextController: controller.passwordController,
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                                height: 50,
                                child: TextFieldWidget(
                                  focusNode: controller.reNewFocus,
                                  actionInput: TextInputAction.done,
                                  inputPass: true,
                                  text: 'Nhập lại mật khẩu',
                                  TextController:
                                      controller.rePasswordController,
                                )),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Button(
                                  showIcon: false,
                                  text: 'Lưu',
                                  onTap: controller.submitChangePass),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
