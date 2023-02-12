import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';

class HydrologicalScreen extends GetView<HydrologicalController> {
  const HydrologicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const AppBarCustom(
          canBack: true,
          title: 'Thủy văn',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const _DropDownSelect(),
                  const SizedBox(height: 20),
                  Obx(() => SelectDate(
                      text: DateFormat("dd-MM-yyyy")
                          .format(controller.selectedDateTime.value)
                          .toString(),
                      onTap: controller.chooseDate)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: Button(
                        text: 'Lấy dữ liệu', onTap: controller.getDisplayData),
                  ),
                ],
              ),
            ),
            const _ChartHydrological()
          ],
        ),
      ),
    );
  }
}

class _ChartHydrological extends StatelessWidget {
  const _ChartHydrological({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HydrologicalController>(builder: (controller) {
      return SfCartesianChart(
          enableAxisAnimation: true,
          title: ChartTitle(
              text: 'Biểu đồ Doanh thu ngày',
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 12)),
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: const StyleChartCustom().legend(),
          trackballBehavior:
              const StyleChartCustom().trackball('series.name: point.y m'),
          series: <ChartSeries<ChartHydrological, String>>[
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataGHTren,
                name: 'GH trên',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.ghTren),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataGHDuoi,
                name: 'GH dưới',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.ghDuoi),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataTTNam,
                name: 'TT năm',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.ttNam),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataKHNam,
                name: 'KH năm',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.khNam),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataTTNamAgo,
                name: 'TT năm 2022',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.ttNamAgo),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataMndbt,
                name: 'MNDBT',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.mndbt),
            LineSeries<ChartHydrological, String>(
                dataSource: controller.dataMnc,
                name: 'MNC',
                xValueMapper: (ChartHydrological data, _) => data.x,
                yValueMapper: (ChartHydrological data, _) => data.mnc),
          ]);
    });
  }
}

class _DropDownSelect extends StatelessWidget {
  const _DropDownSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HydrologicalController>(builder: (controller) {
      return DropdownButtonFormField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          style: TextStyle(
              color: AppColors.secondColor, //<-- SEE HERE
              fontSize: 16,
              fontWeight: FontWeight.bold),
          menuMaxHeight: 400,
          value: controller.dropdownvalueLake,
          focusColor: Colors.transparent,
          // Down Arrow Icon
          icon: Container(
            alignment: Alignment.centerRight,
            child:
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
          ),
          isExpanded: true,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          dropdownColor: const Color.fromARGB(255, 253, 254, 253),
          // Array list of items
          items: controller.listLake.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            controller.dropdownvalueLake = newValue!;

            (context as Element).markNeedsBuild(); //Trick setState in Stl
          });
    });
  }
}
