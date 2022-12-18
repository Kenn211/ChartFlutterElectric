import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';
import 'package:get/get.dart';

class TonnagePage extends StatefulWidget {
  const TonnagePage({super.key});

  @override
  State<TonnagePage> createState() => _TonnagePageState();
}

class _TonnagePageState extends State<TonnagePage> {
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
              const ChartTonnage()
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
  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 10.53, 3.3),
    ChartData(2011, 9.5, 5.4),
    ChartData(2012, 10, 2.65),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(series: <ChartSeries>[
      SplineAreaSeries<ChartData, int>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y),
      SplineAreaSeries<ChartData, int>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y1),
    ]));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}
