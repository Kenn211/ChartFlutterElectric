import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/home/system_controller.dart';
import 'package:test_chart/core.dart';

class SystemPage extends GetView<SystemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'system'.tr,
          canBack: true,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _ItemLang(
              text: 'Tiếng Việt',
              image: Assets.icFlagVn,
            ),
            _ItemLang(
              text: 'English',
              image: Assets.icFlagUSA,
            )
          ],
        ),
      ),
    );
  }
}

class _ItemLang extends StatefulWidget {
  const _ItemLang(
      {super.key,
      required this.text,
      required this.image,
      this.onTap,
      this.index});

  final String text, image;
  final Function()? onTap;
  final num? index;

  @override
  State<_ItemLang> createState() => __ItemLangState();
}

class __ItemLangState extends State<_ItemLang> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap;
          widget.index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: AppColors.primaryColor),
        child: Row(
          children: [
            Image.asset(widget.image),
            const SizedBox(width: 10),
            Container(
                child: Text(
              widget.text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )),
            widget.index == 1 ? Text('a') : Text('b')
          ],
        ),
      ),
    );
  }
}
