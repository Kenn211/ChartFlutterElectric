import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: prefer_relative_imports
import 'package:test_chart/core.dart';

class TonnagePage extends GetView<TonnageController> {
  const TonnagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          canBack: true,
          title: 'load'.tr,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  DropDownSelect(
                      dropDownValue: controller.dropdownvalue,
                      listItem: controller.ragion,
                      onChanged: controller.setValueDropDown),
                  const SizedBox(height: 20),
                  SelectDate(
                    text: DateFormat('dd-MM-yyyy')
                        .format(controller.selectedDateTime)
                        .toString(),
                    onTap: () {
                      controller.chooseDate();
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        alignment: Alignment.centerRight,
                        child: Button(
                          text: 'Lấy dữ liệu',
                          onTap: () {
                            controller.fetchTonnage();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Phụ tải chi tiết',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const ChartTonnage(),
                  const SizedBox(height: 20),
                  const _TableTonnage()
                ],
              );
            })),
      ),
    );
  }
}

class ChartTonnage extends StatelessWidget {
  const ChartTonnage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TonnageController>(builder: (controller) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontSize: 12),
        ),
        primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.compact(),
        ),
        trackballBehavior:
            const StyleChartCustom().trackball('series.name: point.y MW'),
        legend: const StyleChartCustom().legend(),
        series: <ChartSeries<ChartDataTonnage, int>>[
          StackedAreaSeries<ChartDataTonnage, int>(
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false, useSeriesColor: true),
              dataSource: controller.dataChartCk,
              name: 'Chu kỳ tới',
              xValueMapper: (data, _) => data.x,
              yValueMapper: (data, _) => data.y2),
          StackedAreaSeries<ChartDataTonnage, int>(
            dataLabelSettings:
                const DataLabelSettings(isVisible: false, useSeriesColor: true),
            dataSource: controller.dataChartDay,
            name: 'Ngày tới',
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y1,
          ),
        ],
      );
    });
  }
}

class _TableTonnage extends StatelessWidget {
  const _TableTonnage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TonnageController>(builder: (controller) {
      return Table(
        border: TableBorder.all(width: 1.2, color: Colors.blue.shade500),
        children: [
          controller.buildRow(['CK', 'Chu kì tới (IAH)', 'Ngày tới (DAH)'],
              isHeader: true),
          for (var e = 0; e < controller.dataChartCk.length; e++)
            controller.buildRow(
              [
                '${controller.dataChartCk[e].x}',
                '${controller.dataChartCk[e].y2}',
                if (controller.dataChartDay.length <= e)
                  ''
                else
                  controller.dataChartDay[e].y1.toString()
              ],
            )
        ],
      );
    });
  }
}
