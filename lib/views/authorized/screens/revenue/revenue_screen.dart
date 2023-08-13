import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core.dart';

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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GetBuilder<RevenueController>(builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropDownSelect(
                        dropDownValue: controller.dropdownvalueFactory,
                        listItem: controller.listFactory,
                        onChanged: controller.setValueFactory),
                    const SizedBox(height: 20),
                    Obx(() {
                      return SelectDate(
                          text: DateFormat('dd-MM-yyyy')
                              .format(controller.selectedDateTime)
                              .toString(),
                          onTap: controller.chooseDate);
                    }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 160,
                      height: 50,
                      child: Button(
                          text: 'Lấy dữ liệu',
                          onTap: controller.getDisplayRevenue),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),
            const _ChartRevenue(),
            const SizedBox(height: 20),
            const _TableRevenue(),
            const SizedBox(height: 20),
          ],
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
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: const StyleChartCustom().legend(),
          trackballBehavior: const StyleChartCustom()
              .trackball('series.name: point.y đồng/kWh'),
          series: <ChartSeries<ChartRevenue, String>>[
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRcan,
                name: 'Rcan',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rcan! < 0 ? 0 : data.rcan!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRsmp,
                name: 'Rsmp',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rsmp! < 0 ? 0 : data.rsmp!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRbp,
                name: 'Rbp',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rbp! < 0 ? 0 : data.rbp!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRcon,
                name: 'Rcon',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rcon! < 0 ? 0 : data.rcon!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdu,
                name: 'Rdu',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rdu! < 0 ? 0 : data.rdu!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdt,
                name: 'Rdt',
                xValueMapper: (data, _) => 'CK ${data.x}',
                yValueMapper: (data, _) => data.rdt! < 0 ? 0 : data.rdt!),
          ]);
    });
  }
}

class _TableRevenue extends StatelessWidget {
  const _TableRevenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RevenueController>(builder: (controller) {
      return Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(4),
            2: FlexColumnWidth(4),
          },
          border: TableBorder.all(width: 1, color: Colors.black),
          children: [
            controller.buildRow(
                ['Mục', 'Khoản thanh toán', 'Thành tiền (đồng)'],
                isHeader: true),
            controller.buildRow([
              'I',
              'Thanh toán điện năng thị trường (= 1 + 2 + 3 + 4)',
              controller.thanhToanI.toString()
            ], height: 100),
            controller.buildRow([
              '1',
              'Khoản thanh toán tính theo giá điện năng thị trường',
              controller.thanhToanI1.toString()
            ], height: 100, isCate: true),
            controller.buildRow([
              '2',
              'Khoản thanh toán tính theo giá chào',
              controller.thanhToanI2.toString()
            ], height: 100),
            controller.buildRow([
              '3',
              'Khoản thanh toán cho phần sản lượng tăng thêm',
              controller.thanhToanI3.toString()
            ], height: 100, isCate: true),
            controller.buildRow([
              '4',
              'Khoản thanh toán cho phần sản lượng phát sai khác so với sản lượng điện năng huy động theo lệnh điều độ',
              controller.thanhToanI4.toString()
            ], height: 100),
            controller.buildRow([
              'II',
              'Thanh toán công suất thị trường',
              controller.thanhToanII.toString()
            ], height: 100, isCate: true),
            controller.buildRow([
              'III',
              'Thanh toán cho dịch vụ dự phòng điều chỉnh tần số',
              controller.thanhToanIII.toString()
            ], height: 100),
            controller.buildRow(
                ['IV', 'Thanh toán khác', controller.thanhToanIV.toString()],
                height: 100, isCate: true),
            controller.buildRow([
              '',
              'Tổng cộng ( = I + II + III + IV)',
              controller.sumPay.toString()
            ], height: 100),
          ]);
    });
  }
}
