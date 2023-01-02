import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/source_plan_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/source_plan/chart_data_source_plan.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

class SourcePlanScreen extends GetView<SourcePlanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: AppBarCustom(
            canBack: true,
            title: 'Kế hoạch nguồn'.tr,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const _DropDownSelect(),
                        const SelectDate(),
                        Container(
                          width: 160,
                          height: 50,
                          child: Button(
                              text: 'Lấy dữ liệu',
                              onTap: () {
                                controller.fetchPlan();
                              }),
                        ),
                      ])),
              _ChartSourcePlanIAH(),
            ],
          ),
        ));
  }
}

class _ChartSourcePlanIAH extends StatefulWidget {
  const _ChartSourcePlanIAH({super.key});

  @override
  State<_ChartSourcePlanIAH> createState() => __ChartSourcePlanIAHState();
}

class __ChartSourcePlanIAHState extends State<_ChartSourcePlanIAH> {
  late TrackballBehavior _trackball;

  @override
  void initState() {
    _trackball = TrackballBehavior(
        enable: true,
        lineWidth: 3,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: AppColors.secondColor,
        activationMode: ActivationMode.singleTap,
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
        tooltipSettings: InteractiveTooltip(
            canShowMarker: false,
            format: 'series.name: point.y MW',
            color: const Color.fromARGB(255, 181, 180, 180),
            textStyle: TextStyle(color: AppColors.secondColor)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(
        init: SourcePlanController(),
        builder: (controller) {
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(
                labelStyle:
                    const TextStyle(fontSize: 12, color: Colors.transparent)),
            trackballBehavior: _trackball,
            series: <ChartSeries<ChartDataSourcePlan, String>>[
              SplineSeries<ChartDataSourcePlan, String>(
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: false, useSeriesColor: true),
                  dataSource: controller.dataChartIAHTM1,
                  name: 'Tổ máy 1',
                  xValueMapper: (ChartDataSourcePlan data, _) => data.x,
                  yValueMapper: (ChartDataSourcePlan data, _) => data.y1),
              SplineSeries<ChartDataSourcePlan, String>(
                dataLabelSettings: const DataLabelSettings(
                    isVisible: false, useSeriesColor: true),
                dataSource: controller.dataChartIAHTM2,
                name: 'Tổ máy 2',
                xValueMapper: (ChartDataSourcePlan data, _) => data.x,
                yValueMapper: (ChartDataSourcePlan data, _) => data.y2,
              ),
            ],
          );
        });
  }
}

class _DropDownSelect extends StatefulWidget {
  const _DropDownSelect({super.key});

  @override
  State<_DropDownSelect> createState() => __DropDownSelectState();
}

class __DropDownSelectState extends State<_DropDownSelect> {
  final controller = Get.put(SourcePlanController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: AppColors.secondColor)),
      child: DropdownButton(
          underline: const SizedBox(width: 0),
          value: controller.dropdownvalueFactory,
          focusColor: Colors.transparent,
          // Down Arrow Icon
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          dropdownColor: Colors.blue.shade200,
          // Array list of items
          items: controller.factory.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items,
                  style: TextStyle(color: Colors.black.withOpacity(0.5))),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              controller.dropdownvalueFactory = newValue!;
            });
          }),
    );
  }
}
