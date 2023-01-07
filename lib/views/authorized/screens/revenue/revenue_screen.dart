import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/controllers/drawer/revenue_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/revenue/chart_revenue.dart';

class RevenueScreen extends GetView<RevenueController> {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: AppBarCustom(
          canBack: true,
          title: 'revenue'.tr,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [_ChartRevenue()],
        ),
      ),
    );
  }
}

class _ChartRevenue extends StatelessWidget {
  const _ChartRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RevenueController>(builder: (controller) {
      return SfCartesianChart(
          title: ChartTitle(
              text: 'Biểu đồ Doanh thu ngày',
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: Legend(
              isVisible: true,
              isResponsive: true,
              shouldAlwaysShowScrollbar: true,
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
          series: <ChartSeries<ChartRevenue, String>>[
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRcan,
                name: 'SMP',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rcan),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRsmp,
                name: 'CAN',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rsmp),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRbp,
                name: 'CAN',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rbp),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRcon,
                name: 'CAN',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rcon),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdu,
                name: 'CAN',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rdu),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdt,
                name: 'CAN',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) => data.rdt),
          ]);
    });
  }
}
