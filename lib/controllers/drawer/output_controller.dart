import 'package:flutter/material.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';

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
  final Map<String, dynamic> listFactory = {'Nhà máy': 0};
  final _dropdownvalueFactory = 'Nhà máy'.obs;
  String get dropdownvalueFactory => _dropdownvalueFactory.value;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchListFatoryOutput().whenComplete(() => hideLoading());
    });
    super.onInit();
  }

  void setValueFactory(String? valueFactory) {
    _dropdownvalueFactory.value = valueFactory!;
  }

  Future<void> fetchListFatoryOutput() async {
    await BaseClient.get(
      'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_DONVIByID?UNITID=-1&UNIT_NAME=',
      onSuccess: (response) {
        List<ListFactoryOutputModel> dataFactoryRes =
            listFactoryOutputModelFromJson(response.data);
        for (var e in dataFactoryRes) {
          listFactory.addAll({e.unitName: e.unitid});
        }
        update();
      },
    );
  }

  void getDisplayData() async {
    if (dropdownvalueFactory == 'Nhà máy') {
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      await fetchOutput().whenComplete(() => hideLoading());
    }
  }

  Future<void> fetchOutput() async {
    _dataCAN.value = [];
    _dataSMP.value = [];
    _dataGCLN.value = [];
    _dataGCNN.value = [];
    _dataQCAN.value = [];
    _dataQLLTT.value = [];

    await BaseClient.get(
      'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllTHITRUONG_SAUVANHANHByDay2?NGAY=${formatDateAPIToday.toString()}&UNITID=${listFactory[_dropdownvalueFactory.value]}',
      onSuccess: (response) {
        OutPutModel outputModel = outPutModelFromJson(response.data);

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
        update();
      },
    );
  }
}
