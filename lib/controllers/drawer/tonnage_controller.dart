import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class TonnageController extends BaseController {
  final _dataChartCk = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartCk => _dataChartCk;

  final _dataChartDay = <ChartDataTonnage>[].obs;
  RxList<ChartDataTonnage> get dataChartDay => _dataChartDay;

  final _dropdownvalue = 'Quốc Gia'.obs;
  String get dropdownvalue => _dropdownvalue.value;
  int indexDropdownValue = 150;

  final Map<String, dynamic> ragion = {
    "Miền Bắc": 1,
    "Miền Trung": 2,
    "Miền Nam": 3,
    "Quốc Gia": 150,
  };

  void setValueDropDown(String? valueFactory) {
    _dropdownvalue.value = valueFactory!;
  }

  Future<void> fetchTonnage() async {
    showLoading();
    indexDropdownValue = 150;
    for (var entry in ragion.entries) {
      if (_dropdownvalue.value == entry.key) {
        indexDropdownValue = entry.value;
      }
    }
    try {
      _dataChartCk.value = [];
      _dataChartDay.value = [];

      await BaseClient()
          .get(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_IAHByDay?NGAY=${formatDateAPIToday.toString()}&ID_NODE=${indexDropdownValue.toString()}')
          .then((value) {
        List<TonnageModel> tonnageModelRes = tonnageModelFromJson(value.body);
        if (tonnageModelRes.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar('error',
              'Không có dữ liệu phụ tải ${dropdownvalue.toString()} ngày này');
        } else {
          for (var e in tonnageModelRes) {
            _dataChartCk.add(ChartDataTonnage(x: e.chuky, y2: e.giatri));
          }
          BaseClient()
              .get(
                  'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_DAHByDay?NGAY=${formatDateAPITomorrow.toString()}&ID_NODE=${indexDropdownValue.toString()}')
              .then((value) {
            List<TonnageModel> tonnageModelRes1 =
                tonnageModelFromJson(value.body);
            if (tonnageModelRes1.isEmpty) {
              debugPrintStack();
            } else {
              for (var e in tonnageModelRes1) {
                _dataChartDay.add(ChartDataTonnage(x: e.chuky, y1: e.giatri));
              }
              hideLoading();
              CustomSnackbar.showSuccessToast(
                  'Thành công', 'Dữ liệu phụ tải ${dropdownvalue.toString()}');
            }
            update();
          });
        }
      });
    } catch (e) {
      debugPrintStack(label: e.toString());
    }
    hideLoading();

    update();
  }
}
