import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core.dart';

class SystemPage extends GetView<SystemController> {
  const SystemPage({super.key});

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
      body: GetBuilder<LanguagesController>(
          init: LanguagesController(),
          builder: (controller) {
            return DelayedReveal(
              delay: const Duration(milliseconds: 2),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.optionsLocales.entries.map((item) {
                        return Column(
                          key: ValueKey(item.key),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              dense: true,
                              horizontalTitleGap: 0,
                              leading: Text(
                                LanguagesController.getFlag(
                                    item.value['languageCode']),
                                style: TextStyle(fontSize: 24.sp),
                              ),
                              title: Text(
                                controller.locale.value == 'en_US'
                                    ? item.value['en_description']
                                    : item.value['vi_description'],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: controller.locale.value == item.key
                                      ? AppColors.primaryColor
                                      : const Color(0xFF141416),
                                ),
                              ),
                              trailing: (controller.locale.value == item.key)
                                  ? Icon(
                                      Icons.check_rounded,
                                      color: AppColors.primaryColor,
                                    )
                                  : null,
                              onTap: () {
                                controller.setCurrentLocale(item.key);
                              },
                            ),
                            const Divider(height: 1)
                          ],
                        );
                      }).toList()
                    ],
                  )),
            );
          }),
    );
  }
}
