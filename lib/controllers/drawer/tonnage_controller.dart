import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
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
      _dataChartDay.value = [];

      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_IAHByDay?NGAY=${dateSelected.toString()}&ID_NODE=${indexDropdownValue.toInt()}'))
          .then((value) {
        List<TonnageModel> _tonnageModel = tonnageModelFromJson(value.body);
        if (_tonnageModel.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar('error',
              'Không có dữ liệu phụ tải ${dropdownvalue.toString()} ngày này');
        } else {
          _tonnageModel.forEach((e) {
            _dataChartCk.add(ChartDataTonnage(x: e.chuky, y2: e.giatri));
          });
          http
              .get(Uri.parse(
                  'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllPHUTAI_DAHByDay?NGAY=${dateSelectedNextDay.toString()}&ID_NODE=${indexDropdownValue.toInt()}'))
              .then((value) {
            List<TonnageModel> _tonnageModel1 =
                tonnageModelFromJson(value.body);
            if (_tonnageModel1.isEmpty) {
              print('empty');
            } else {
              _tonnageModel1.forEach((e) {
                _dataChartDay.add(ChartDataTonnage(x: e.chuky, y1: e.giatri));
              });
              hideLoading();
              CustomSnackbar.showSuccessToast(
                  'Thành công', 'Dữ liệu phụ tải ${dropdownvalue.toString()}');
            }
            update();
          });
        }
      });
    } catch (e) {
      print(e);
    }
    hideLoading();

    update();
  }
}
