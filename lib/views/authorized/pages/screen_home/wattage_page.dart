import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../core.dart';

class WattagePage extends GetView<WattageController> {
  const WattagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          title: 'Công suất'.tr,
          canBack: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(
                () => SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: 200, ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 70, color: Colors.green),
                      GaugeRange(
                          startValue: 70, endValue: 140, color: Colors.orange),
                      GaugeRange(
                          startValue: 140, endValue: 200, color: Colors.red)
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: controller.displayCS,
                        enableAnimation: true,
                      )
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          children: [
                            Text(
                              '${controller.displayCS} MW',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.displayNameTM,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        angle: 90,
                        positionFactor: 1.4,
                      )
                    ])
                  ],
                ),
              ),
              const _TableWattage(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableWattage extends StatelessWidget {
  const _TableWattage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WattageController>(builder: (controller) {
      return Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(4),
          },
          border: TableBorder.all(width: 1, color: Colors.black),
          children: [
            controller
                .buildRow(['Tên tổ máy/nhà máy', 'Công suất'], isHeader: true),
            for (var item in controller.dataCongSuat)
              controller.buildRow(
                [item.tentb, item.congsuat.toString()],
                onTap: () {
                  controller.funcDisplayCS(item.idtb.toString());
                },
              )
          ]);
    });
  }
}
