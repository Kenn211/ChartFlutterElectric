import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/home/home_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/views/authorized/pages/lake_level_evolution.dart';
import 'package:test_chart/views/authorized/screens/main_drawer.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    bool changeFlag = true;

    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
            title: 'home'.tr,
            leading: IconButton(
              onPressed: () {
                controller.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              color: AppColors.secondColor,
              icon: const Icon(Icons.menu_rounded),
            ),
            actions: GestureDetector(
              onTap: () {
                controller.handleChangeLang();
                changeFlag = !changeFlag;
              },
              child: changeFlag == true
                  ? Image.asset(Assets.icFlagVn)
                  : Image.asset(Assets.icFlagUSA),
            )),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.topLeft,
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${'hello'.tr}! Vanh',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ItemDisplayBody(
                    colorBackground: AppColors.secondColor,
                    text: 'currentCapacity'.tr,
                    numData: '150 MW',
                    onTap: () {
                      Get.to(const LakeLevelEvolution());
                    },
                    icon: CupertinoIcons.chart_bar,
                  ),
                  _ItemDisplayBody(
                    colorBackground: AppColors.secondColor,
                    text: 'waterlevel'.tr,
                    numData: '150 m',
                    icon: CupertinoIcons.bars,
                    onTap: () {
                      controller.developing();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${'output'.tr} ${'and'.tr} ${'revenue'.tr}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ItemDisplayBody(
                    colorBackground: const Color.fromARGB(255, 45, 175, 50),
                    text: 'output'.tr,
                    numData: '150 M',
                    icon: CupertinoIcons.bolt_fill,
                  ),
                  _ItemDisplayBody(
                    colorBackground: Color.fromARGB(255, 45, 175, 50),
                    text: 'revenue'.tr,
                    numData: '150 m',
                    icon: CupertinoIcons.money_dollar_circle,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'function'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              _ItemFunctions(
                text: 'repair'.tr,
                textDesc: 'trackEditHistory'.tr,
                icon: CupertinoIcons.hammer_fill,
              ),
              const SizedBox(height: 10),
              _ItemFunctions(
                text: 'system'.tr,
                textDesc: 'updateinfo'.tr,
                icon: Icons.settings,
                onTap: () {
                  Get.toNamed(Routes.systemPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemDisplayBody extends StatelessWidget {
  const _ItemDisplayBody(
      {super.key,
      required this.colorBackground,
      required this.text,
      required this.numData,
      this.icon,
      this.onTap});

  final Color colorBackground;
  final String text, numData;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        height: 150,
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(numData,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Icon(icon, size: 45, color: Colors.white.withOpacity(0.5)),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemFunctions extends StatelessWidget {
  const _ItemFunctions(
      {super.key,
      required this.text,
      required this.textDesc,
      this.onTap,
      required this.icon});
  final String text, textDesc;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 217, 217),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(42))),
              child: Icon(
                icon,
                color: AppColors.secondColor,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  textDesc,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
