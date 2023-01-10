import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:intl/intl.dart';

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

                        ///Select Date
                        Obx(() {
                          return SelectDate(
                              text: DateFormat("dd-MM-yyyy")
                                  .format(controller.selectedDateTime.value)
                                  .toString(),
                              onTap: controller.chooseDate);
                        }),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const _CheckBoxWidget(),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                  'Xem chu kì hiện tại và ba chu kì tới',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: Button(
                              text: 'Lấy dữ liệu',
                              onTap: controller.getDisplayData),
                        ),
                      ])),
              const SizedBox(height: 20),
              const _ChartSourcePlanIAH(),
              Row(children: const [_TableSourcePlanIAH()]),
              const SizedBox(height: 20),
              const _ChartSourcePlanDAH(),
              const _TableSourcePlanDAH()
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
                format: 'series.name: point.y MW',
                color: const Color.fromARGB(255, 181, 180, 180),
                textStyle: TextStyle(color: AppColors.secondColor))),
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
        legend: Legend(
            isVisible: true,
            alignment: ChartAlignment.center,
            position: LegendPosition.bottom),
        zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
        primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
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
        series: [
          for (var i = 0; i < controller.dataToMayDAH.length; i++)
            SplineSeries(
              dataLabelSettings: const DataLabelSettings(
                  isVisible: false, useSeriesColor: true),
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

class _DropDownSelect extends StatefulWidget {
  const _DropDownSelect({Key? key}) : super(key: key);

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
  const _CheckBoxWidget({Key? key}) : super(key: key);

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

class _TableSourcePlanIAH extends StatelessWidget {
  const _TableSourcePlanIAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SizedBox(
        child: Table(
            border: TableBorder.all(width: 1.2, color: Colors.blue.shade500),
            children: [
              controller.buildRow([
                'CK',
                '00:30',
              ], isHeader: true),
              // for (var e = 0; e < controller.dataChartCentralDAH.length; e++)
              //   controller.buildRow([
              //     '${controller.dataTableIAH[e].ck}',
              //     '${controller.dataChartNorthDAH[e].y1}',
              //     '${controller.dataChartCentralDAH[e].y2}',
              //     '${controller.dataChartSouthDAH[e].y3}',
              //     '${controller.dataChartNationDAH[e].y4}'
              //   ])
            ]),
      );
    });
  }
}

class _TableSourcePlanDAH extends StatelessWidget {
  const _TableSourcePlanDAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SourcePlanController>(builder: (controller) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
            border: TableBorder.all(width: 1.2, color: Colors.blue.shade500),
            children: [
              controller
                  .buildRow(['CK', 'MB', 'MT', 'MN', 'GBM'], isHeader: true),
              // for (var e = 0; e < controller.dataChartCentralDAH.length; e++)
              //   controller.buildRow([
              //     '${controller.dataTableIAH[e].ck}',
              //     '${controller.dataChartNorthDAH[e].y1}',
              //     '${controller.dataChartCentralDAH[e].y2}',
              //     '${controller.dataChartSouthDAH[e].y3}',
              //     '${controller.dataChartNationDAH[e].y4}'
              //   ])
            ]),
      );
    });
  }
}
