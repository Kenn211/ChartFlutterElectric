import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/marginal_price_controller.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/shared/constants/colors.dart';
import 'package:test_chart/shared/widgets/app_bar_custom.dart';

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
            // const _ChartColumn(),
            _ChartColumn(),
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
            // _TableQuantityProduct()
          ],
        ),
      ),
    );
  }
}

class _ChartColumn extends StatefulWidget {
  _ChartColumn({Key? key}) : super(key: key);

  @override
  _ChartColumnState createState() => _ChartColumnState();
}

class _ChartColumnState extends State<_ChartColumn> {
  late TooltipBehavior _tooltip;
  final controller = Get.put(MarginalPriceController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        controller.dataColumnChart;
      });
    });
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(fontSize: 12),
          maximumLabels: 100,
          autoScrollingDelta: 5,
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 5000, interval: 1000),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: controller.dataColumnChart,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: 'Sản lượng',
              color: AppColors.secondColor)
        ]);
  }
}
