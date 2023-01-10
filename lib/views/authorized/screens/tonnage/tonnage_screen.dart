import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                const _DropDownSelect(),
                const SizedBox(height: 20),
                Obx(() {
                  return SelectDate(
                    text: DateFormat("dd-MM-yyyy")
                        .format(controller.selectedDateTime.value)
                        .toString(),
                    onTap: () {
                      controller.chooseDate();
                    },
                  );
                }),
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
                          }),
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
            )),
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
              xValueMapper: (ChartDataTonnage data, _) => data.x,
              yValueMapper: (ChartDataTonnage data, _) => data.y2),
          StackedAreaSeries<ChartDataTonnage, int>(
            dataLabelSettings:
                const DataLabelSettings(isVisible: false, useSeriesColor: true),
            dataSource: controller.dataChartDay,
            name: 'Ngày tới',
            xValueMapper: (ChartDataTonnage data, _) => data.x,
            yValueMapper: (ChartDataTonnage data, _) => data.y1,
          ),
        ],
      );
    });
  }
}

class _DropDownSelect extends StatefulWidget {
  const _DropDownSelect({Key? key}) : super(key: key);

  @override
  State<_DropDownSelect> createState() => __DropDownSelectState();
}

class __DropDownSelectState extends State<_DropDownSelect> {
  final controller = Get.put(TonnageController());
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        style: TextStyle(
            color: AppColors.secondColor, //<-- SEE HERE
            fontSize: 16,
            fontWeight: FontWeight.bold),
        isExpanded: true,
        value: controller.dropdownvalue,
        focusColor: Colors.transparent,
        // Down Arrow Icon
        icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        dropdownColor: const Color.fromARGB(255, 253, 254, 253),
        // Array list of items
        items: controller.ragion.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            controller.dropdownvalue = newValue!;
          });
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
                controller.dataChartDay.length <= e
                    ? ''
                    : controller.dataChartDay[e].y1.toString()
              ],
            )
        ],
      );
    });
  }
}
