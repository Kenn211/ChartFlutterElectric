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
  String dropdownvalueFactory = 'Nhà máy';

  @override
  void onReady() {
    showLoading();
  }

  @override
  void onInit() {
    fetchListFatoryOutput();
    super.onInit();
  }

  Future<void> fetchListFatoryOutput() async {
    try {
      indexFactory = 0;
      listFactory = ['Nhà máy'];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_DONVIByID?UNITID=-1&UNIT_NAME='))
          .then((value) {
        List<ListFactoryOutputModel> _dataFactory =
            listFactoryOutputModelFromJson(value.body);
        _dataFactory.forEach((e) {
          listFactory.add(e.unitName);
          dataFactoryOutPut.add(e);
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
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      dataFactoryOutPut.forEach((e) {
        if (dropdownvalueFactory == e.unitName) {
          indexFactory = e.unitid;
          fetchOutput();
        }
      });
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
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllTHITRUONG_SAUVANHANHByDay2?NGAY=2022-12-28&UNITID=40055'))
          .then((value) {
        OutPutModel _outputModel = outPutModelFromJson(value.body);

        //
        _outputModel.can.forEach((e) {
          _dataCAN.add(ChartOutput(x: e.chuKy.toString(), can: e.giaTri));
        });

        _outputModel.smp.forEach((e) {
          _dataSMP.add(ChartOutput(x: e.chuKy.toString(), smp: e.giaTri));
        });

        _outputModel.gcln.forEach((e) {
          _dataGCLN.add(ChartOutput(x: e.chuKy.toString(), gcln: e.giaTri));
        });

        _outputModel.gcnn.forEach((e) {
          _dataGCNN.add(ChartOutput(x: e.chuKy.toString(), gcnn: e.giaTri));
        });

        _outputModel.qcan.forEach((e) {
          _dataQCAN.add(ChartOutput(x: e.chuKy.toString(), qcan: e.giaTri));
        });

        _outputModel.qlltt.forEach((e) {
          _dataQLLTT.add(ChartOutput(x: e.chuKy.toString(), qlltt: e.giaTri));
        });
        update();
      });
    } catch (e) {
      print(e);
    }
    update();
    hideLoading();
  }
}
