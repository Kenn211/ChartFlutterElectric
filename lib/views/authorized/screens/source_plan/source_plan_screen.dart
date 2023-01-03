import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/source_plan_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/source_plan/chart_data_source_plan.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

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
            title: 'Kế hoạch nguồn'.tr,
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
                  child: Column(
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
                        const _DropDownSelect(),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: const Text('Ngày',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                        ),
                        const SizedBox(height: 10),
                        const SelectDate(),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _CheckBoxWidget(),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                  'Xem chu kì hiện tại và ba chu kì tới',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        Container(
                          width: 160,
                          height: 50,
                          child: Button(
                              text: 'Lấy dữ liệu',
                              onTap: () {
                                controller.getDisplayData();
                              }),
                        ),
                      ])),
              const _ChartSourcePlanIAH(),
              const _ChartSourcePlanDAH()
            ],
          ),
        ));
  }
}

class _ChartSourcePlanIAH extends StatelessWidget {
  const _ChartSourcePlanIAH({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            labelStyle:
                const TextStyle(fontSize: 12, color: Colors.transparent)),
        trackballBehavior: TrackballBehavior(
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
                textStyle: TextStyle(color: AppColors.secondColor))),
        series: <ChartSeries<ChartDataSourcePlan, String>>[
          SplineSeries<ChartDataSourcePlan, String>(
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false, useSeriesColor: true),
              dataSource: controller.dataChartIAHTM1,
              name: 'Tổ máy 1',
              xValueMapper: (ChartDataSourcePlan data, _) => data.x,
              yValueMapper: (ChartDataSourcePlan data, _) => data.y1),
          SplineSeries<ChartDataSourcePlan, String>(
            dataLabelSettings:
                const DataLabelSettings(isVisible: false, useSeriesColor: true),
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

class _ChartSourcePlanDAH extends StatelessWidget {
  const _ChartSourcePlanDAH({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            labelStyle:
                const TextStyle(fontSize: 12, color: Colors.transparent)),
        trackballBehavior: TrackballBehavior(
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
                textStyle: TextStyle(color: AppColors.secondColor))),
        series: <ChartSeries<ChartDataSourcePlan, String>>[
          SplineSeries<ChartDataSourcePlan, String>(
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false, useSeriesColor: true),
              dataSource: controller.dataChartDAHTM1,
              name: 'Tổ máy 1',
              xValueMapper: (ChartDataSourcePlan data, _) => data.x,
              yValueMapper: (ChartDataSourcePlan data, _) => data.y3),
          SplineSeries<ChartDataSourcePlan, String>(
            dataLabelSettings:
                const DataLabelSettings(isVisible: false, useSeriesColor: true),
            dataSource: controller.dataChartDAHTM2,
            name: 'Tổ máy 2',
            xValueMapper: (ChartDataSourcePlan data, _) => data.x,
            yValueMapper: (ChartDataSourcePlan data, _) => data.y4,
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1, color: AppColors.secondColor)),
        child: GetBuilder<SourcePlanController>(builder: (controller) {
          return DropdownButton(
              underline: const SizedBox(width: 0),
              value: controller.dropdownvalueFactory,
              focusColor: Colors.transparent,
              // Down Arrow Icon
              icon: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor),
              ),
              isExpanded: true,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              dropdownColor: Colors.blue.shade200,
              // Array list of items
              items: controller.listFactory.map((String items) {
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
              });
        }));
  }
}

class _CheckBoxWidget extends StatefulWidget {
  const _CheckBoxWidget({super.key});

  @override
  State<_CheckBoxWidget> createState() => __CheckBoxWidgetState();
}

class __CheckBoxWidgetState extends State<_CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
