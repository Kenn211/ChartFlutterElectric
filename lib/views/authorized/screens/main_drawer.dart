import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/home/home_controller.dart';
import 'package:test_chart/core.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(Assets.imgDrawer),
                )),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'title_app'.tr,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
            const SizedBox(height: 20),
            _ItemDrawer(
              text: 'load'.tr,
              iconItem: CupertinoIcons.hammer,
              onTap: () {
                Get.toNamed(Routes.tonnageScreen);
                controller.closeDrawer();
              },
            ),
            _ItemDrawer(
                text: 'Giá biên',
                iconItem: CupertinoIcons.arrowtriangle_up,
                onTap: () {
                  Get.toNamed(Routes.marginalPriceScreen);
                  controller.closeDrawer();
                }),
            _ItemDrawer(
              text: 'output'.tr,
              iconItem: CupertinoIcons.arrowtriangle_up,
              onTap: () {
                Get.toNamed(Routes.outputScreen);
                controller.closeDrawer();
              },
            ),
            _ItemDrawer(
                text: 'hydrological'.tr,
                iconItem: CupertinoIcons.cloud_drizzle_fill,
                onTap: () {
                  controller.closeDrawer();
                }),
            _ItemDrawer(
                text: 'revenue'.tr,
                iconItem: CupertinoIcons.money_dollar,
                onTap: () {
                  controller.closeDrawer();
                }),
            _ItemDrawer(
                text: 'sourcePlan'.tr,
                iconItem: CupertinoIcons.chart_bar,
                onTap: () {
                  Get.toNamed(Routes.sourcePlanScreen);
                  controller.closeDrawer();
                }),
            _ItemDrawer(
              text: 'logout'.tr,
              logout: true,
              iconItem: Icons.logout,
              onTap: () {
                controller.handleLogout();
              },
            ),
          ],
        ),
      );
    });
  }
}

class _ItemDrawer extends StatelessWidget {
  const _ItemDrawer(
      {super.key,
      required this.iconItem,
      required this.text,
      this.logout = false,
      this.onTap});

  final IconData? iconItem;
  final String text;
  final bool logout;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Icon(
                iconItem,
                size: 30,
                color:
                    logout == true ? Colors.red : Colors.black.withOpacity(0.5),
              ),
              const SizedBox(width: 30),
              Text(text,
                  style: TextStyle(
                      fontSize: 15,
                      color: logout == true ? Colors.red : Colors.black))
            ],
          ),
        ),
        onTap: onTap ?? () {});
  }
}
