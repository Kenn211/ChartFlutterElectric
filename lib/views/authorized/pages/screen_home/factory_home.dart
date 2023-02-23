import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_chart/core.dart';

class FactoryHome extends GetView<FactoryHomeController> {
  const FactoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'factory'.tr,
          canBack: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vui lòng chọn nhà máy',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14,
              ),
              Obx(() => DropDownSelect(
                    dropDownValue: controller.dropdownValueFactory,
                    listItem: controller.listFactory,
                    onChanged: controller.setValueFactory,
                  )),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                width: Constants.width,
                height: 50,
                child: Button(text: 'Lấy dữ liệu', onTap: controller.getData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
