import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/home/home_controller.dart';
import 'package:test_chart/shared/app_shared.dart';
import 'package:test_chart/views/authorized/pages/lake_level_evolution.dart';
import 'package:test_chart/views/authorized/screens/quantity_product.dart';
import 'package:test_chart/views/authorized/screens/tonnage_page.dart';

class HomePage extends GetView<HomeController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void closeDrawer() {
      _scaffoldKey.currentState!.closeDrawer();
    }

    // final controller = Get.put(LanguagesController());

    bool changeFlag = true;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
            title: 'home'.tr,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              color: AppColors.secondColor,
              icon: const Icon(Icons.menu_rounded),
            ),
            actions: InkWell(
              onTap: () {
                controller.handleChangLang();
                changeFlag = !changeFlag;
              },
              child: Image.asset(
                changeFlag == false ? Assets.icFlagVn : Assets.icFlagUSA,
              ),
            )),
      ),
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            text: 'Phụ tải',
            iconItem: CupertinoIcons.hammer,
            onTap: () {
              Get.to(() => TonnagePage());
              closeDrawer();
            },
          ),
          _ItemDrawer(
              text: 'Giá biên',
              iconItem: CupertinoIcons.arrowtriangle_up,
              onTap: () {
                closeDrawer();
              }),
          _ItemDrawer(
            text: 'Sản lượng',
            iconItem: CupertinoIcons.arrowtriangle_up,
            onTap: () {
              Get.to(QuantityProduct());
              closeDrawer();
            },
          ),
          _ItemDrawer(
              text: 'Thủy văn',
              iconItem: CupertinoIcons.cloud_drizzle_fill,
              onTap: () {
                closeDrawer();
              }),
          _ItemDrawer(
              text: 'Doanh thu',
              iconItem: CupertinoIcons.money_dollar,
              onTap: () {
                closeDrawer();
              }),
          _ItemDrawer(
              text: 'Kế hoạch nguồn',
              iconItem: CupertinoIcons.chart_bar,
              onTap: () {
                closeDrawer();
              }),
          const _ItemDrawer(
            text: 'Đăng xuất',
            logout: true,
            iconItem: Icons.logout,
          ),
        ],
      )),
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
                child: const Text(
                  'Xin chào! Vanh',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ItemDisplayBody(
                    colorBackground: AppColors.secondColor,
                    text: 'Công suất hiện tại',
                    numData: '150 MW',
                    onTap: () {
                      Get.to(LakeLevelEvolution());
                    },
                    icon: CupertinoIcons.chart_bar,
                  ),
                  _ItemDisplayBody(
                    colorBackground: AppColors.secondColor,
                    text: 'Mực nước',
                    numData: '150 m',
                    icon: CupertinoIcons.bars,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Sản lượng và doanh thu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _ItemDisplayBody(
                    colorBackground: Color.fromARGB(255, 45, 175, 50),
                    text: 'Sản lượng',
                    numData: '150 M',
                    icon: CupertinoIcons.bolt_fill,
                  ),
                  _ItemDisplayBody(
                    colorBackground: Color.fromARGB(255, 45, 175, 50),
                    text: 'Doanh thu',
                    numData: '150 m',
                    icon: CupertinoIcons.money_dollar_circle,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Chức năng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              const _ItemFunctions(
                text: 'Sửa chữa',
                textDesc: 'Theo dõi lịch sử chỉnh sửa',
                icon: CupertinoIcons.hammer_fill,
              ),
              const SizedBox(height: 10),
              const _ItemFunctions(
                text: 'Hệ thống',
                textDesc: 'Cập nhật thông tin',
                icon: Icons.settings,
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
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 218, 217, 217),
            borderRadius: BorderRadius.all(Radius.circular(8))),
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
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
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
    );
  }
}
