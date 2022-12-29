import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/models/drawer/marginal_price/marginal_price_model.dart';
import 'package:test_chart/models/drawer/marginal_price/table_marginal_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class MarginalPriceController extends BaseController {
  //IAH
  final _dataChartNorthIAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartNorthIAH => _dataChartNorthIAH;

  final _dataChartCentralIAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartCentralIAH => _dataChartCentralIAH;

  final _dataChartSouthIAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartSouthIAH => _dataChartSouthIAH;

  final _dataChartNationIAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartNationIAH => _dataChartNationIAH;

  //DAH
  final _dataChartNorthDAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartNorthDAH => _dataChartNorthDAH;

  final _dataChartCentralDAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartCentralDAH => _dataChartCentralDAH;

  final _dataChartSouthDAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartSouthDAH => _dataChartSouthDAH;

  final _dataChartNationDAH = <ChartData>[].obs;
  RxList<ChartData> get dataChartNationDAH => _dataChartNationDAH;

  final _dataTableIAH = <ItemTableMarginal>[].obs;
  RxList<ItemTableMarginal> get dataTableIAH => _dataTableIAH;

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
  void onInit() async {
    super.onInit();
  }

  Future<void> fetchPriceData() async {
    print(today);
    showLoading();
    try {
      await http
          .get(Uri.parse(
              'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllGIABIEN_IAHByDay?NGAY=${dateSelected}'))
          .then((value) {
        List<PriceModel> _priceModel = priceModelFromJson(value.body);
        if (_priceModel.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar(
              'error', 'Không có dữ liệu giá biên ngày ${dateSelectSnackbar}');
        } else {
          _dataChartCentralIAH.value = [];
          _dataChartNorthIAH.value = [];
          _dataChartSouthIAH.value = [];
          _dataChartNationIAH.value = [];
          _dataTableIAH.value = [];
          _priceModel.forEach((e) {
            if (e.idNode == 1) {
              _dataTableIAH.add(ItemTableMarginal(ck: e.chuky));
              _dataChartNorthIAH
                  .add(ChartData(x: 'Chu kỳ ${e.chuky}', y1: e.giatri));
            } else if (e.idNode == 2) {
              _dataChartCentralIAH
                  .add(ChartData(x: 'Chu kỳ ${e.chuky}', y2: e.giatri));
            } else if (e.idNode == 3) {
              _dataChartSouthIAH
                  .add(ChartData(x: 'Chu kỳ ${e.chuky}', y3: e.giatri));
            } else if (e.idNode == 150) {
              _dataChartNationIAH
                  .add(ChartData(x: 'Chu kỳ ${e.chuky}', y4: e.giatri));
            }
          });
        }
      });

      await http
          .get(Uri.parse(
              'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllGIABIEN_IAHByDay?NGAY=${dateSelectedNextDay}'))
          .then((value) {
        List<PriceModel> _priceModel = priceModelFromJson(value.body);

        _dataChartCentralDAH.value = [];
        _dataChartNorthDAH.value = [];
        _dataChartSouthDAH.value = [];
        _dataChartNationDAH.value = [];
        _priceModel.forEach((e) {
          if (e.idNode == 1) {
            _dataChartNorthDAH
                .add(ChartData(x: 'Chu kỳ ${e.chuky}', y1: e.giatri));
          } else if (e.idNode == 2) {
            _dataChartCentralDAH
                .add(ChartData(x: 'Chu kỳ ${e.chuky}', y2: e.giatri));
          } else if (e.idNode == 3) {
            _dataChartSouthDAH
                .add(ChartData(x: 'Chu kỳ ${e.chuky}', y3: e.giatri));
          } else if (e.idNode == 150) {
            _dataChartNationDAH
                .add(ChartData(x: 'Chu kỳ ${e.chuky}', y4: e.giatri));
          }
        });
        hideLoading();
        CustomSnackbar.showSuccessToast(
            'Thành công', 'Giá biên ngày ${dateSelectSnackbar}');
      });
    } catch (e) {
      print(e);
    }
    hideLoading();
    update();
  }
}
