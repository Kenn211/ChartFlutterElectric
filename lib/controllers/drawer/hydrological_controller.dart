import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class HydrologicalController extends BaseController {
  final _dataGHTren = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataGHTren => _dataGHTren;

  final _dataGHDuoi = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataGHDuoi => _dataGHDuoi;

  final _dataTTNam = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataTTNam => _dataTTNam;

  final _dataKHNam = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataKHNam => _dataKHNam;

  final _dataTTNamAgo = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataTTNamAgo => _dataTTNamAgo;

  final _dataMndbt = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataMndbt => _dataMndbt;

  final _dataMnc = <ChartHydrological>[].obs;
  RxList<ChartHydrological> get dataMnc => _dataMnc;

  //Categories Factory
  List<ListFactoryOutputModel> dataFactory = [];
  int indexFactory = 0;
  List<String> listFactory = ['Nhà máy'];
  String dropdownvalueFactory = 'Nhà máy';
}
