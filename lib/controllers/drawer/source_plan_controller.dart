import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/models/drawer/source_plan/chart_data_source_plan.dart';
import 'package:test_chart/models/drawer/source_plan/source_plan_model.dart';

class SourcePlanController extends BaseController {
  //IAH
  final _dataChartIAHTM1 = <ChartDataSourcePlan>[].obs;
  RxList<ChartDataSourcePlan> get dataChartIAHTM1 => _dataChartIAHTM1;

  final _dataChartIAHTM2 = <ChartDataSourcePlan>[].obs;
  RxList<ChartDataSourcePlan> get dataChartIAHTM2 => _dataChartIAHTM2;

  //DAH
  final _dataChartDAHTM1 = <ChartDataSourcePlan>[].obs;
  RxList<ChartDataSourcePlan> get dataChartDAHTM1 => _dataChartDAHTM1;

  final _dataChartDAHTM2 = <ChartDataSourcePlan>[].obs;
  RxList<ChartDataSourcePlan> get dataChartDAHTM2 => _dataChartDAHTM2;

  int indexFactory = 0;
  String dropdownvalueFactory = 'Nhà máy';
  final factory = ['Nhà máy', 'A Vương', 'Hải Phòng'];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchPlan() async {
    try {
      indexFactory = 0;
      if (dropdownvalueFactory == 'Nhà máy') {}
      //IAH
      _dataChartIAHTM1.value = [];
      _dataChartIAHTM2.value = [];

      //DAH
      _dataChartDAHTM1.value = [];
      _dataChartDAHTM2.value = [];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay?NGAY=2022-12-27&ID_NM=55'))
          .then((value) {
        List<SourcePlanModel> _planModel = sourcePlanModelFromJson(value.body);
        _planModel.forEach((e) {
          if (e.tenTm == 'H1') {
            _dataChartIAHTM1.add(ChartDataSourcePlan(
                x: e.chuky.toString(), y1: e.giatri, name: e.tenTm));
          } else if (e.tenTm == 'H2') {
            _dataChartIAHTM2.add(ChartDataSourcePlan(
                x: e.chuky.toString(), y2: e.giatri, name: e.tenTm));
          }
        });
      });
    } catch (e) {
      print(e);
    }
    hideLoading();
    update();
  }
}
