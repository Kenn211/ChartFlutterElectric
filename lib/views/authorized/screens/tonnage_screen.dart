import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/tonnage_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/tonnage/chart_dart_tonnage.dart';
import 'package:get/get.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

class TonnagePage extends GetView<TonnageController> {
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
              const SizedBox(height: 20),
              const ChartTonnage(),
              Row(
                children: [
                  _DropDownSelect(),
                  Stack(
                    children: [
                      SelectDate(),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        top: 4,
                        child: Container(
                          width: 130,
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Button(
                              text: 'Lấy dữ liệu',
                              onTap: () {
                                controller.fetchTonnage();
                                print(controller.dateSelected);
                                print(controller.dateSelectedNextDay);
                              }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              _TableTonnage()
            ],
          ),
        ),
      ),
    );
  }
}

class ChartTonnage extends StatefulWidget {
  const ChartTonnage({super.key});

  @override
  State<ChartTonnage> createState() => _ChartTonnageState();
}

class _ChartTonnageState extends State<ChartTonnage> {
  late TrackballBehavior _trackball;

  @override
  void initState() {
    _trackball = TrackballBehavior(
        enable: true,
        lineWidth: 5,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: AppColors.secondColor,
        activationMode: ActivationMode.longPress,
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
        tooltipSettings: InteractiveTooltip(
            canShowMarker: false,
            format: 'series.name: point.y đồng/kWh',
            color: const Color.fromARGB(255, 181, 180, 180),
            textStyle: TextStyle(color: AppColors.secondColor)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TonnageController>(
        init: TonnageController(),
        builder: (controller) {
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(
                labelStyle:
                    const TextStyle(fontSize: 12, color: Colors.transparent)),
            trackballBehavior: _trackball,
            series: <ChartSeries<ChartDataTonnage, int>>[
              StackedAreaSeries<ChartDataTonnage, int>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartCk,
                  name: 'Chu kỳ tới',
                  xValueMapper: (ChartDataTonnage data, _) => data.x,
                  yValueMapper: (ChartDataTonnage data, _) => data.y2,
                  color: Colors.blue),
              StackedAreaSeries<ChartDataTonnage, int>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartDay,
                  name: 'Ngày tới',
                  xValueMapper: (ChartDataTonnage data, _) => data.x,
                  yValueMapper: (ChartDataTonnage data, _) => data.y1,
                  color: Colors.amber),
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
  final controller = Get.put(TonnageController());
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: controller.dropdownvalue,
        focusColor: Colors.transparent,
        // Down Arrow Icon
        icon: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryColor,
          ),
        ),

        // Array list of items
        items: controller.ragion.map((String items) {
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
            controller.dropdownvalue = newValue!;
          });
        });
  }
}

class _TableTonnage extends StatelessWidget {
  const _TableTonnage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TonnageController>(
        init: TonnageController(),
        builder: (controller) {
          return Table(
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [
                controller
                    .buildRow(['CK', 'Chu kì tới', 'Ngày tới'], isHeader: true),
                for (var e = 0; e < controller.dataChartDay.length; e++)
                  TableRow(
                    children: [
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(controller.dataChartDay[e].x.toString()),
                      ),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(controller.dataChartCk[e].y2.toString()),
                      ),
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(controller.dataChartDay[e].y1.toString()),
                      ),
                    ],
                  ),
              ]);
        });
  }
}
