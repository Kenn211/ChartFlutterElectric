import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core.dart';
import '../base_controller.dart';

class TonnageController extends BaseController {
  final _dataChartCk = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartCk => _dataChartCk;

  final _dataChartDay = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartDay => _dataChartDay;

  final _dropdownvalue = 'Quốc Gia'.obs;
  String get dropdownvalue => _dropdownvalue.value;

  final Map<String, dynamic> ragion = {
    'Miền Bắc': 1,
    'Miền Trung': 2,
    'Miền Nam': 3,
    'Quốc Gia': 150,
  };

  void setValueDropDown(String? valueFactory) {
    _dropdownvalue.value = valueFactory!;
  }

  Future<void> fetchTonnage() async {
    showLoading();

    _dataChartCk.value = [];
    _dataChartDay.value = [];

    await BaseClient.get(
        'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_IAHByDay?NGAY=${formatDateAPIToday.toString()}&ID_NODE=${ragion[_dropdownvalue.value]}',
        onSuccess: (response) {
      final tonnageModelRes = tonnageModelFromJson(response.data);
      if (tonnageModelRes.isEmpty) {
        hideLoading();
        CustomSnackbar.snackBar('error',
            'Không có dữ liệu phụ tải ${dropdownvalue.toString()} ngày này');
      } else {
        for (final e in tonnageModelRes) {
          _dataChartCk.add(ChartDataTonnage(x: e.chuky, y2: e.giatri));
        }
        BaseClient.get(
            'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_DAHByDay?NGAY=${formatDateAPITomorrow.toString()}&ID_NODE=${ragion[_dropdownvalue.value]}',
            onSuccess: (response) {
          final tonnageModelRes1 = tonnageModelFromJson(response.data);
          if (tonnageModelRes1.isEmpty) {
            debugPrintStack();
          } else {
            for (final e in tonnageModelRes1) {
              _dataChartDay.add(ChartDataTonnage(x: e.chuky, y1: e.giatri));
            }
          }
          update();
        });
      }
    }).whenComplete(hideLoading);
  }
}
