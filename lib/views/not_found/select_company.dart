import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class SelectCompanyScreen extends GetView<SelectCompanyController> {
  const SelectCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetBuilder<SelectCompanyController>(
            init: SelectCompanyController(),
            builder: (controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  DelayedReveal(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'welcome_app'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(5.0, 5.0),
                            blurRadius: 1.0,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DelayedReveal(
                    delay: const Duration(milliseconds: 300),
                    child: Image.asset('assets/icons/logo_app_electric.png'),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DelayedReveal(
                    delay: const Duration(milliseconds: 300),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Vui lòng chọn công ty'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  DropDownSelect(
                    dropDownValue: controller.dropdownValueCompany,
                    listItem: controller.listCompany,
                    onChanged: controller.setValueCompany,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: Constants.width,
                    height: 50,
                    child: Button(
                        text: 'Trang chủ',
                        showIcon: false,
                        onTap: controller.getListCompany),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
