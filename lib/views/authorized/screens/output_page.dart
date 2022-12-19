import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/output_controller.dart';
import 'package:test_chart/shared/constants/colors.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';
import 'package:test_chart/shared/widgets/table_custom.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const _ChartQuantityProduct(),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      Container(
                        height: 8,
                        width: 25,
                        color: Colors.purple,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Qmq',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        height: 8,
                        width: 25,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Qlltt',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  )
                ]),
              ),
              const SizedBox(height: 30),
              _TableQuantityProduct()
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartQuantityProduct extends StatefulWidget {
  const _ChartQuantityProduct({super.key});

  @override
  State<_ChartQuantityProduct> createState() => __ChartQuantityProductState();
}

class __ChartQuantityProductState extends State<_ChartQuantityProduct> {
  final List<ChartData> chartData = <ChartData>[
    ChartData('0', 2001, 1000),
    ChartData('5', 111, 1500),
    ChartData('10', 2000, 2001),
    ChartData('15', 2000, 2001),
    ChartData('20', 2000, 2001),
    ChartData('25', 2000, 2001),
    ChartData('30', 2000, 2001),
    ChartData('35', 2000, 2001),
    ChartData('35', 2000, 2001),
    ChartData('4548', 2000, 2001),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(
            title: ChartTitle(
                text: 'Qmp & Qlldt',
                textStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 14)),
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries>[
          StackedLineSeries<ChartData, String>(
              groupName: 'Group A',
              color: Colors.amber,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1),
          StackedLineSeries<ChartData, String>(
              groupName: 'Group B',
              dataSource: chartData,
              color: Colors.purple,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2),
        ]));
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2);
  final String x;
  final double y1;
  final double y2;
}

class _TableQuantityProduct extends StatefulWidget {
  const _TableQuantityProduct({super.key});

  @override
  State<_TableQuantityProduct> createState() => __TableQuantityProductState();
}

class __TableQuantityProductState extends State<_TableQuantityProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: TableBorder.all(color: Colors.black),
        children: [
          TableRow(
              decoration: BoxDecoration(color: AppColors.primaryColor),
              children: const [
                TableCustom(textTable: 'Chu kỳ', colorText: true),
                TableCustom(textTable: 'Qmq', colorText: true),
                TableCustom(textTable: 'Qlltt', colorText: true),
              ]),
          const TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                TableCustom(textTable: '1'),
                TableCustom(textTable: '-1'),
                TableCustom(textTable: '-1'),
              ]),
        ],
      ),
    );
  }
}
