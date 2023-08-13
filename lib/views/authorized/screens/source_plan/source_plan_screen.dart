import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core.dart';

class SourcePlanScreen extends GetView<SourcePlanController> {
  const SourcePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: AppBarCustom(
            canBack: true,
            title: 'Kế hoạch vận hành nguồn'.tr,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child:
                      GetBuilder<SourcePlanController>(builder: (controller) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: const Text('Nhà máy',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18)),
                          ),
                          const SizedBox(height: 10),
                          DropDownSelect(
                              dropDownValue: controller.dropdownvalueFactory,
                              listItem: controller.listFactory,
                              onChanged: controller.setValueFactory),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: const Text('Ngày',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18)),
                          ),
                          const SizedBox(height: 10),

                          ///Select Date
                          Obx(() => SelectDate(
                              text: DateFormat('dd-MM-yyyy')
                                  .format(controller.selectedDateTime)
                                  .toString(),
                              onTap: controller.chooseDate)),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 160,
                            height: 50,
                            child: Button(
                                text: 'Lấy dữ liệu',
                                onTap: controller.getDisplayData),
                          ),
                        ]);
                  })),
              const SizedBox(height: 20),
              const _ChartSourcePlanIAH(),
              const SizedBox(height: 20),
              const _ChartSourcePlanDAH(),
            ],
          ),
        ));
  }
}

class _ChartSourcePlanIAH extends StatelessWidget {
  const _ChartSourcePlanIAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SfCartesianChart(
        title: ChartTitle(
            text: 'Biểu đồ huy động công suất chu kì tới nhà máy điện',
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
        zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
        legend: const StyleChartCustom().legend(),
        trackballBehavior:
            const StyleChartCustom().trackball('series.name: point.y MW'),
        series: [
          for (var i = 0; i < controller.dataToMayIAH.length; i++)
            SplineSeries(
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false, useSeriesColor: true),
              dataSource: controller.dataToMayIAH[i].chuky,
              name: controller.dataToMayIAH[i].tenTm,
              xValueMapper: (data, _) => 'CK ${data.chuKyDesc.toString()}',
              yValueMapper: (data, _) => data.giaTri,
            )
        ],
      );
    });
  }
}

class _ChartSourcePlanDAH extends StatelessWidget {
  const _ChartSourcePlanDAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SfCartesianChart(
        title: ChartTitle(
            text: 'Biểu đồ huy động công suất ngày tới nhà máy điện',
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
        zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
        legend: const StyleChartCustom().legend(),
        trackballBehavior:
            const StyleChartCustom().trackball('series.name: point.y MW'),
        series: [
          for (var i = 0; i < controller.dataToMayDAH.length; i++)
            SplineSeries(
              dataLabelSettings: const DataLabelSettings(
                isVisible: false,
                useSeriesColor: true,
              ),
              dataSource: controller.dataToMayDAH[i].chuky,
              name: controller.dataToMayDAH[i].tenTm,
              xValueMapper: (data, _) => 'CK ${data.chuKyDesc.toString()}',
              yValueMapper: (data, _) => data.giaTri,
            )
        ],
      );
    });
  }
}
