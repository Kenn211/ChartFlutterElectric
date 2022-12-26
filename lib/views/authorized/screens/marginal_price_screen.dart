import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:test_chart/shared/widgets/txt_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const _ChartColumn(),
            SelectDate(day: 'Giá biên'),
            Button(
                text: 'TapTap',
                onTap: () {
                  controller.fetchPriceData();
                  print(controller.dateSelected);
                })
          ],
        ),
      ),
    );
  }
}

class _ChartColumn extends StatefulWidget {
  const _ChartColumn({Key? key}) : super(key: key);

  @override
  _ChartColumnState createState() => _ChartColumnState();
}

class _ChartColumnState extends State<_ChartColumn> {
  late TrackballBehavior _trackball;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    _tooltipBehavior = TooltipBehavior(enable: true);

    _trackball = TrackballBehavior(
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
        lineWidth: 11.5,
        lineColor: Colors.red,
        activationMode: ActivationMode.longPress,
        markerSettings: const TrackballMarkerSettings(
            markerVisibility: TrackballVisibilityMode.visible),
        tooltipSettings:
            const InteractiveTooltip(format: 'point.x : point.y MW'));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarginalPriceController>(
      init: MarginalPriceController(),
      builder: (controller) {
        return SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            primaryXAxis:
                CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
            trackballBehavior: _trackball,
            series: <ChartSeries<ChartData, String>>[
              SplineSeries<ChartData, String>(
                  dataSource: controller.dataChartNorth,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Miền Bắc',
                  color: Colors.red),
              SplineSeries<ChartData, String>(
                  dataSource: controller.dataChartCentral,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Miền Trung',
                  color: Colors.amber),
              SplineSeries<ChartData, String>(
                  dataSource: controller.dataChartSouth,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Miền Nam',
                  color: Colors.black),
              SplineSeries<ChartData, String>(
                  dataSource: controller.dataChartNation,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Miền Nam',
                  color: Colors.blue)
            ]);
      },
    );
  }
}
