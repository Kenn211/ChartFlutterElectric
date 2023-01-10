import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/shared/widgets/select_date.dart';
import 'package:intl/intl.dart';

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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const _DropDownSelect(),
                  const SizedBox(height: 20),
                  Obx(() {
                    return SelectDate(
                        text: DateFormat("dd-MM-yyyy")
                            .format(controller.selectedDateTime.value)
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
              ),
            ),
            const SizedBox(height: 20),
            const _ChartRevenue(),
            const SizedBox(height: 20),
            const _TableRevenue()
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
          primaryYAxis: CategoryAxis(isVisible: false),
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
                name: 'Rcan',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rcan! < 0 ? 0 : data.rcan!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRsmp,
                name: 'Rsmp',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rsmp! < 0 ? 0 : data.rsmp!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRbp,
                name: 'Rbp',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rbp! < 0 ? 0 : data.rbp!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRcon,
                name: 'Rcon',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rcon! < 0 ? 0 : data.rcon!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdu,
                name: 'Rdu',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rdu! < 0 ? 0 : data.rdu!),
            StackedColumnSeries<ChartRevenue, String>(
                groupName: 'Group A',
                dataSource: controller.dataRdt,
                name: 'Rdt',
                xValueMapper: (ChartRevenue data, _) => 'CK ${data.x}',
                yValueMapper: (ChartRevenue data, _) =>
                    data.rdt! < 0 ? 0 : data.rdt!),
          ]);
    });
  }
}

class _DropDownSelect extends StatelessWidget {
  const _DropDownSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1, color: AppColors.secondColor)),
        child: GetBuilder<RevenueController>(builder: (controller) {
          return DropdownButton(
              menuMaxHeight: 400,
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
                controller.dropdownvalueFactory = newValue!;

                (context as Element).markNeedsBuild(); //Trick setState in Stl
              });
        }));
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
          border: TableBorder.all(width: 1.0, color: Colors.black),
          children: [
            controller.buildRow(
                ['Mục', 'Khoản thanh toán', 'Thành tiền (đồng)'],
                isHeader: true),
            controller.buildRow(['I', 'TTT', controller.thanhToanI.toString()]),
            controller
                .buildRow(['1', 'TTT', controller.thanhToanI1.toString()]),
            controller
                .buildRow(['2', 'TTT', controller.thanhToanI2.toString()]),
            controller
                .buildRow(['3', 'TTT', controller.thanhToanI3.toString()]),
            controller
                .buildRow(['4', 'TTT', controller.thanhToanI4.toString()]),
            controller
                .buildRow(['II', 'TTT', controller.thanhToanII.toString()]),
            controller
                .buildRow(['III', 'TTT', controller.thanhToanIII.toString()]),
            controller
                .buildRow(['IV', 'TTT', controller.thanhToanIV.toString()]),
            controller
                .buildRow(['', 'Tổng cộng', controller.sumPay.toString()]),
          ]);
    });
  }
}
