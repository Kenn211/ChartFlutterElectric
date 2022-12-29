import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/tonnage/chart_dart_tonnage.dart';
import 'package:test_chart/models/drawer/tonnage/tonnage_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class TonnageController extends BaseController {
  final _dataChartCk = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartCk => _dataChartCk;

  final _dataChartDay = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartDay => _dataChartDay;

  String dropdownvalue = 'Quốc Gia';
  int indexDropdownValue = 150;

  final ragion = [
    "Miền Bắc",
    "Miền Trung",
    "Miền Nam",
    "Quốc Gia",
  ];

  TableRow buildRow(List<String> cells, {bool isHeader = false}) {
    final style = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontSize: 15,
    );

    return TableRow(
        children: cells
            .map((cell) => Container(
                  color: isHeader ? AppColors.primaryColor : Colors.white,
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(cell, style: style),
                ))
            .toList());
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchTonnage() async {
    showLoading();
    try {
      indexDropdownValue = 0;
      if (dropdownvalue == 'Quốc Gia') {
        indexDropdownValue = 150;
      } else if (dropdownvalue == 'Miền Bắc') {
        indexDropdownValue = 1;
      } else if (dropdownvalue == 'Miền Trung') {
        indexDropdownValue = 2;
      } else if (dropdownvalue == 'Miền Nam') {
        indexDropdownValue = 3;
      }

      _dataChartCk.value = [];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_IAHByDay?NGAY=${dateSelected}&ID_NODE=${indexDropdownValue.toInt()}'))
          .then((value) {
        List<TonnageModel> _tonnageModel = tonnageModelFromJson(value.body);
        if (_tonnageModel.isEmpty) {
          CustomSnackbar.snackBar(
              'error', 'Không có dữ liệu giá biên ngày ${dateSelectSnackbar}');
        } else {
          _tonnageModel.forEach((e) {
            _dataChartCk.add(ChartDataTonnage(x: e.chuky, y2: e.giatri));
          });
        }
      });

      _dataChartDay.value = [];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_DAHByDay?NGAY=${dateSelectedNextDay}&ID_NODE=${indexDropdownValue.toInt()}'))
          .then((value) {
        List<TonnageModel> _tonnageModel1 = tonnageModelFromJson(value.body);
        _tonnageModel1.forEach((e) {
          _dataChartDay.add(ChartDataTonnage(x: e.chuky, y1: e.giatri));
        });
      });
    } catch (e) {
      print(e);
    }
    hideLoading();

    update();
  }
}
