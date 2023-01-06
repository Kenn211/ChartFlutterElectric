import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/shared/widgets/item_region.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';
import 'package:intl/intl.dart';

class MarginalPriceScreen extends GetView<MarginalPriceController> {
  const MarginalPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const AppBarCustom(
          canBack: true,
          title: 'Giá biên',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Giá biên chu kì tới',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            const _ChartColumnIAH(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 250,
                    child: Stack(
                      children: [
                        Obx(() {
                          return SelectDate(
                            text: DateFormat("dd-MM-yyyy")
                                .format(controller.selectedDateTime.value)
                                .toString(),
                            onTap: () {
                              controller.chooseDate();
                            },
                            isStack: true,
                          );
                        }),
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
                                  controller.fetchPriceData();
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const _TableMarginalIAH()
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Giá biên ngày tới',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            const _ChartColumnDAH(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [SizedBox(height: 20), _TableMarginalDAH()],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChartColumnIAH extends StatelessWidget {
  const _ChartColumnIAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarginalPriceController>(
      builder: (controller) {
        return SfCartesianChart(
            primaryXAxis: CategoryAxis(
                labelStyle:
                    const TextStyle(fontSize: 12, color: Colors.transparent)),
            legend: Legend(
                isVisible: true,
                alignment: ChartAlignment.center,
                shouldAlwaysShowScrollbar: true,
                position: LegendPosition.bottom),
            trackballBehavior: TrackballBehavior(
                enable: true,
                lineWidth: 3,
                tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                tooltipAlignment: ChartAlignment.center,
                lineColor: AppColors.secondColor,
                hideDelay: 1,
                activationMode: ActivationMode.singleTap,
                markerSettings: const TrackballMarkerSettings(
                    height: 10,
                    width: 10,
                    markerVisibility: TrackballVisibilityMode.visible),
                tooltipSettings: InteractiveTooltip(
                    canShowMarker: false,
                    format: 'series.name: point.y đồng/kWh',
                    color: const Color.fromARGB(255, 181, 180, 180),
                    textStyle: TextStyle(color: AppColors.secondColor))),
            series: <ChartSeries<ChartData, String>>[
              SplineSeries<ChartData, String>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartNorthIAH,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y1,
                  name: 'Miền Bắc',
                  color: Colors.green),
              SplineSeries<ChartData, String>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartCentralIAH,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y2,
                  name: 'Miền Trung',
                  color: Colors.blue),
              SplineSeries<ChartData, String>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartSouthIAH,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y3,
                  name: 'Miền Nam',
                  color: Colors.black),
              SplineSeries<ChartData, String>(
                  markerSettings: const MarkerSettings(isVisible: false),
                  dataSource: controller.dataChartNationIAH,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y4,
                  name: 'Quốc gia',
                  color: Colors.amberAccent)
            ]);
      },
    );
  }
}

class _ChartColumnDAH extends StatelessWidget {
  const _ChartColumnDAH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarginalPriceController>(
      builder: (controller) {
        return SfCartesianChart(
          legend: Legend(
              isVisible: true,
              shouldAlwaysShowScrollbar: true,
              alignment: ChartAlignment.center,
              position: LegendPosition.bottom),
          trackballBehavior: TrackballBehavior(
              enable: true,
              lineWidth: 3,
              tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
              tooltipAlignment: ChartAlignment.center,
              lineColor: AppColors.secondColor,
              activationMode: ActivationMode.singleTap,
              markerSettings: const TrackballMarkerSettings(
                  height: 10,
                  width: 10,
                  markerVisibility: TrackballVisibilityMode.visible),
              tooltipSettings: InteractiveTooltip(
                  canShowMarker: false,
                  format: 'series.name: point.y đồng/kWh',
                  color: const Color.fromARGB(255, 181, 180, 180),
                  textStyle: TextStyle(color: AppColors.secondColor))),
          primaryXAxis: CategoryAxis(
              labelStyle:
                  const TextStyle(fontSize: 12, color: Colors.transparent)),
          series: <ChartSeries<ChartData, String>>[
            SplineSeries<ChartData, String>(
                markerSettings: const MarkerSettings(isVisible: false),
                dataSource: controller.dataChartNorthDAH,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y1,
                name: 'Miền Bắc',
                color: Colors.green),
            SplineSeries<ChartData, String>(
                markerSettings: const MarkerSettings(isVisible: false),
                dataSource: controller.dataChartCentralDAH,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y2,
                name: 'Miền Trung',
                color: Colors.blue),
            SplineSeries<ChartData, String>(
                markerSettings: const MarkerSettings(isVisible: false),
                dataSource: controller.dataChartSouthDAH,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y3,
                name: 'Miền Nam',
                color: Colors.black),
            SplineSeries<ChartData, String>(
                markerSettings: const MarkerSettings(isVisible: false),
                dataSource: controller.dataChartNationDAH,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y4,
                name: 'Giá bên mua',
                color: Colors.amberAccent)
          ],
        );
      },
    );
  }
}

class _TableMarginalIAH extends StatelessWidget {
  const _TableMarginalIAH({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarginalPriceController>(builder: (controller) {
      return Table(
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            controller
                .buildRow(['CK', 'MB', 'MT', 'MN', 'GBM'], isHeader: true),
            for (var e = 0; e < controller.dataChartCentralIAH.length; e++)
              controller.buildRow([
                '${controller.dataTableIAH[e].ck}',
                '${controller.dataChartNorthIAH[e].y1}',
                '${controller.dataChartCentralIAH[e].y2}',
                '${controller.dataChartSouthIAH[e].y3}',
                '${controller.dataChartNationIAH[e].y4}'
              ])
          ]);
    });
  }
}

class _TableMarginalDAH extends StatelessWidget {
  const _TableMarginalDAH({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarginalPriceController>(builder: (controller) {
      return Table(
          border: TableBorder.all(width: 1.2, color: Colors.blue.shade500),
          children: [
            controller
                .buildRow(['CK', 'MB', 'MT', 'MN', 'GBM'], isHeader: true),
            for (var e = 0; e < controller.dataChartCentralDAH.length; e++)
              controller.buildRow([
                '${controller.dataTableIAH[e].ck}',
                '${controller.dataChartNorthDAH[e].y1}',
                '${controller.dataChartCentralDAH[e].y2}',
                '${controller.dataChartSouthDAH[e].y3}',
                '${controller.dataChartNationDAH[e].y4}'
              ])
          ]);
    });
  }
}
