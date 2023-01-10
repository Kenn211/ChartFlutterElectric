import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_chart/core.dart';
import 'package:intl/intl.dart';

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
        child: Column(
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
                      Obx(() {
                        return SelectDate(
                          text: DateFormat("dd-MM-yyyy")
                              .format(controller.selectedDateTime.value)
                              .toString(),
                          onTap: () {
                            controller.chooseDate();
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 160,
                        height: 50,
                        child: Button(
                            text: 'Lấy dữ liệu',
                            onTap: () {
                              controller.getDisplayData();
                            }),
                      ),
                    ])),
            const _ChartOutPutQMQ(),
            const SizedBox(height: 20),
            const _ChartOutPut(),
            // _TableQuantityProduct()
          ],
        ),
      ),
    );
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
    return GetBuilder<OutputController>(builder: (controller) {
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
          value: controller.dropdownvalueFactory,
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
          items: controller.listFactory.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                ));
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              controller.dropdownvalueFactory = newValue!;
            });
          });
    });
  }
}

class _ChartOutPut extends StatelessWidget {
  const _ChartOutPut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutputController>(builder: (controller) {
      return SfCartesianChart(
          title: ChartTitle(
              text: 'Biểu đồ CAN & SMP',
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(fontSize: 12),
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
          ),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: const StyleChartCustom().legend(),
          trackballBehavior: const StyleChartCustom()
              .trackball('series.name: point.y đồng/kWh'),
          series: <ChartSeries<ChartOutput, String>>[
            StackedColumnSeries<ChartOutput, String>(
                groupName: 'Group A',
                dataSource: controller.dataSMP,
                name: 'SMP',
                xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
                yValueMapper: (ChartOutput data, _) => data.smp),
            StackedColumnSeries<ChartOutput, String>(
                groupName: 'Group A',
                dataSource: controller.dataCAN,
                name: 'CAN',
                xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
                yValueMapper: (ChartOutput data, _) => data.can),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataGCLN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.gcln,
              name: 'Giá chào lớn nhất',
            ),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataGCNN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.gcnn,
              name: 'Giá chào nhỏ nhất',
            ),
          ]);
    });
  }
}

class _ChartOutPutQMQ extends StatelessWidget {
  const _ChartOutPutQMQ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutputController>(
      builder: (controller) {
        return SfCartesianChart(
          title: ChartTitle(
              text: 'Biểu đồ QMQ & Qlltt',
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(fontSize: 12),
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
          ),
          zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true),
          legend: const StyleChartCustom().legend(),
          trackballBehavior: const StyleChartCustom()
              .trackball('series.name: point.y đồng/kWh'),
          series: <ChartSeries<ChartOutput, String>>[
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataQCAN,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.qcan,
              name: 'Qmq',
            ),
            SplineSeries<ChartOutput, String>(
              markerSettings: const MarkerSettings(isVisible: false),
              dataSource: controller.dataQLLTT,
              xValueMapper: (ChartOutput data, _) => 'CK ${data.x}',
              yValueMapper: (ChartOutput data, _) => data.qlltt,
              name: 'Qlltt',
            ),
          ],
        );
      },
    );
  }
}
