import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  static final HomeController controller = Get.find<HomeController>();
  static final List<ItemDrawer> listDrawer = [
    ItemDrawer(
      index: 1,
      text: 'load'.tr,
      iconItem: CupertinoIcons.hammer,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 2,
      text: 'marginalCost'.tr,
      iconItem: CupertinoIcons.arrowtriangle_up,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 3,
      text: 'output'.tr,
      iconItem: CupertinoIcons.arrowtriangle_up,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 4,
      text: 'hydrological'.tr,
      iconItem: CupertinoIcons.cloud_drizzle_fill,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 5,
      text: 'revenue'.tr,
      iconItem: CupertinoIcons.money_dollar,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 6,
      text: 'sourcePlan'.tr,
      iconItem: CupertinoIcons.chart_bar,
      onTap: controller.setDrawerIndex,
    ),
    ItemDrawer(
      index: 7,
      text: 'logout'.tr,
      logout: true,
      iconItem: Icons.logout,
      onTap: controller.setDrawerIndex,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          for (var item in listDrawer) item
        ],
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.index,
    required this.iconItem,
    required this.text,
    this.logout = false,
    required this.onTap,
  });

  final int index;
  final IconData? iconItem;
  final String text;
  final bool logout;
  final ValueChanged<int> onTap;

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
            const SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: logout == true ? Colors.red : Colors.black,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        onTap(index);
      },
    );
  }
}
