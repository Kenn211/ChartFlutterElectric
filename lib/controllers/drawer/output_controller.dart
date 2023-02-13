import 'package:flutter/cupertino.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/models/drawer/output/chart_out_put.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/models/drawer/output/list_factory_output_model.dart';
import 'package:test_chart/models/drawer/output/out_put_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class OutputController extends BaseController {
  final _dataCAN = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataCAN => _dataCAN;

  final _dataSMP = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataSMP => _dataSMP;

  final _dataGCNN = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataGCNN => _dataGCNN;

  final _dataGCLN = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataGCLN => _dataGCLN;

  final _dataQCAN = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataQCAN => _dataQCAN;

  final _dataQLLTT = <ChartOutput>[].obs;
  RxList<ChartOutput> get dataQLLTT => _dataQLLTT;

  //Categories Factory
  List<ListFactoryOutputModel> dataFactoryOutPut = [];
  int indexFactory = 0;
  List<String> listFactory = ['Nhà máy'];
  final _dropdownvalueFactory = 'Nhà máy'.obs;
  String get dropdownvalueFactory => _dropdownvalueFactory.value;

  @override
  void onReady() {
    showLoading();
  }

  @override
  void onInit() {
    fetchListFatoryOutput();
    super.onInit();
  }

  void setValueFactory(String? valueFactory) {
    _dropdownvalueFactory.value = valueFactory!;
  }

  Future<void> fetchListFatoryOutput() async {
    try {
      indexFactory = 0;
      listFactory = ['Nhà máy'];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_DONVIByID?UNITID=-1&UNIT_NAME='))
          .then((value) {
        List<ListFactoryOutputModel> dataFactoryRes =
            listFactoryOutputModelFromJson(value.body);
        for (var e in dataFactoryRes) {
          listFactory.add(e.unitName);
          dataFactoryOutPut.add(e);
        }
      });
    } catch (e) {
      debugPrintStack();
    }
    hideLoading();
    update();
  }

  void getDisplayData() {
    indexFactory = 0;
    if (dropdownvalueFactory == 'Nhà máy') {
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      for (var e in dataFactoryOutPut) {
        if (dropdownvalueFactory == e.unitName) {
          indexFactory = e.unitid;
          fetchOutput();
        }
      }
    }
  }

  Future<void> fetchOutput() async {
    try {
      _dataCAN.value = [];
      _dataSMP.value = [];
      _dataGCLN.value = [];
      _dataGCNN.value = [];
      _dataQCAN.value = [];
      _dataQLLTT.value = [];

      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllTHITRUONG_SAUVANHANHByDay2?NGAY=${formatDateAPIToday.toString()}&UNITID=${indexFactory.toInt()}'))
          .then((value) {
        OutPutModel outputModel = outPutModelFromJson(value.body);

        //
        for (var e in outputModel.can) {
          _dataCAN.add(ChartOutput(x: e.chuKy.toString(), can: e.giaTri));
        }

        for (var e in outputModel.smp) {
          _dataSMP.add(ChartOutput(x: e.chuKy.toString(), smp: e.giaTri));
        }

        for (var e in outputModel.gcln) {
          _dataGCLN.add(ChartOutput(x: e.chuKy.toString(), gcln: e.giaTri));
        }

        for (var e in outputModel.gcnn) {
          _dataGCNN.add(ChartOutput(x: e.chuKy.toString(), gcnn: e.giaTri));
        }

        for (var e in outputModel.qcan) {
          _dataQCAN.add(ChartOutput(x: e.chuKy.toString(), qcan: e.giaTri));
        }

        for (var e in outputModel.qlltt) {
          _dataQLLTT.add(ChartOutput(x: e.chuKy.toString(), qlltt: e.giaTri));
        }
        hideLoading();

        CustomSnackbar.showSuccessToast('Thành công',
            'Sản lượng nhà máy ${dropdownvalueFactory.toString()}');
      });
    } catch (e) {
      debugPrintStack();
    }
    update();
  }
}
