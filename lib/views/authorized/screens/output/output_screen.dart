import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/output_controller.dart';
import 'package:test_chart/models/drawer/output/chart_out_put.dart';
import 'package:test_chart/shared/constants/colors.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';
import 'package:intl/intl.dart';

class OutputScreen extends GetView<OutputController> {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const AppBarCustom(
          canBack: true,
          title: 'Sản lượng',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                      const SizedBox(height: 10),
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

            const _ChartOutPut(),
            const _ChartOutPutQMQ()
            // _TableQuantityProduct()
          ],
        ),
      ),
    );
  }
}

class _DropDownSelect extends StatefulWidget {
  const _DropDownSelect({super.key});

  @override
  State<_DropDownSelect> createState() => __DropDownSelectState();
}

class __DropDownSelectState extends State<_DropDownSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1, color: AppColors.secondColor)),
        child: GetBuilder<OutputController>(builder: (controller) {
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

class _ChartOutPut extends StatelessWidget {
  const _ChartOutPut({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutputController>(builder: (controller) {
      return SfCartesianChart(
          title: ChartTitle(
              text: 'CAN & SMP',
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: Legend(
              isVisible: true,
              alignment: ChartAlignment.center,
              position: LegendPosition.bottom),
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
                  format: 'series.name: point.y đồng/kWh',
                  color: const Color.fromARGB(255, 181, 180, 180),
                  textStyle: TextStyle(color: AppColors.secondColor))),
          series: <ChartSeries<ChartOutput, String>>[
            StackedColumnSeries<ChartOutput, String>(
                groupName: 'Group A',
                dataSource: controller.dataCAN,
                name: 'CAN',
                xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
                yValueMapper: (ChartOutput data, _) => data.can),
            StackedColumnSeries<ChartOutput, String>(
                groupName: 'Group A',
                dataSource: controller.dataSMP,
                name: 'SMP',
                xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
                yValueMapper: (ChartOutput data, _) => data.smp),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataGCNN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.gcnn,
              name: 'Giá chào nhỏ nhất',
            ),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataGCLN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.gcln,
              name: 'Giá chào lớn nhất',
            ),
          ]);
    });
  }
}

class _ChartOutPutQMQ extends StatelessWidget {
  const _ChartOutPutQMQ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutputController>(builder: (controller) {
      return SfCartesianChart(
          title: ChartTitle(
              text: 'QMQ & Qlltt',
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: Legend(
              isVisible: true,
              alignment: ChartAlignment.center,
              position: LegendPosition.bottom),
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
                  format: 'series.name: point.y MWh',
                  color: const Color.fromARGB(255, 181, 180, 180),
                  textStyle: TextStyle(color: AppColors.secondColor))),
          series: <ChartSeries<ChartOutput, String>>[
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataQCAN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.qcan,
              name: 'Qmq',
            ),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataQLLTT,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.qlltt,
              name: 'Qlltt',
            ),
          ]);
    });
  }
}
