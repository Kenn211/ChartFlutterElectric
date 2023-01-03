import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/models/drawer/source_plan/chart_data_source_plan.dart';
import 'package:test_chart/models/drawer/source_plan/list_factory_model.dart';
import 'package:test_chart/models/drawer/source_plan/source_plan_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class SourcePlanController extends BaseController with StateMixin {
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

  List<ListFactoryModel> dataFactory = [];
  int indexFactory = 0;
  List<String> listFactory = ['Nhà máy'];
  String dropdownvalueFactory = 'Nhà máy';

  @override
  void onReady() {
    showLoading();
  }

  @override
  void onInit() {
    fetchListFatory();
    super.onInit();
  }

  Future<void> fetchListFatory() async {
    try {
      indexFactory = 0;
      listFactory = ['Nhà máy'];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_NHAMAYByID?ID_NM=-1&TEN_NM='))
          .then((value) {
        List<ListFactoryModel> _dataFactory =
            listFactoryModelFromJson(value.body);
        _dataFactory.forEach((e) {
          listFactory.add(e.tenNm);
          dataFactory.add(e);
        });
      });
    } catch (e) {
      print(e);
    }
    hideLoading();
    update();
  }

  void getDisplayData() {
    indexFactory = 0;
    if (dropdownvalueFactory == 'Nhà máy') {
      //IAH
      _dataChartIAHTM1.value = [];
      _dataChartIAHTM2.value = [];

      //DAH
      _dataChartDAHTM1.value = [];
      _dataChartDAHTM2.value = [];
      update();
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      dataFactory.forEach((e) {
        if (dropdownvalueFactory == e.tenNm) {
          indexFactory = e.idNm;
          fetchPlan();
          print(indexFactory);
        }
      });
    }
  }

  Future<void> fetchPlan() async {
    try {
      //IAH
      _dataChartIAHTM1.value = [];
      _dataChartIAHTM2.value = [];

      //DAH
      _dataChartDAHTM1.value = [];
      _dataChartDAHTM2.value = [];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay?NGAY=${dateSelected.toString()}&ID_NM=${indexFactory.toInt()}'))
          .then((value) {
        List<SourcePlanModel> _planModel = sourcePlanModelFromJson(value.body);
        if (_planModel.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar('error', 'Không có dữ liệu ngày này');
        } else {
          _planModel.forEach((e) {
            if (e.tenTm == 'H1') {
              _dataChartIAHTM1.add(
                  ChartDataSourcePlan(x: e.chuky.toString(), y1: e.giatri));
            } else if (e.tenTm == 'H2') {
              _dataChartIAHTM2.add(
                  ChartDataSourcePlan(x: e.chuky.toString(), y2: e.giatri));
            }
          });

          http
              .get(Uri.parse(
                  'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay?NGAY=${dateSelectedNextDay.toString()}&ID_NM=${indexFactory.toInt()}'))
              .then((value) {
            List<SourcePlanModel> _planModel1 =
                sourcePlanModelFromJson(value.body);

            _planModel1.forEach((e) {
              if (e.tenTm == 'H1') {
                _dataChartDAHTM1.add(
                    ChartDataSourcePlan(x: e.chuky.toString(), y3: e.giatri));
              } else if (e.tenTm == 'H2') {
                _dataChartDAHTM2.add(
                    ChartDataSourcePlan(x: e.chuky.toString(), y4: e.giatri));
              }
            });
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

  @override
  void onClose() {
    super.onClose();
  }
}
