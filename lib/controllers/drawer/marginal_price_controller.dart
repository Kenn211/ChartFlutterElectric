import 'package:get/get.dart';
import '../../core.dart';
import '../base_controller.dart';

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

  Future<void> fetchPriceData() async {
    showLoading();
    //IAH
    _dataChartCentralIAH.value = [];
    _dataChartNorthIAH.value = [];
    _dataChartSouthIAH.value = [];
    _dataChartNationIAH.value = [];
    _dataTableIAH.value = [];

    // DAH
    _dataChartCentralDAH.value = [];
    _dataChartNorthDAH.value = [];
    _dataChartSouthDAH.value = [];
    _dataChartNationDAH.value = [];
    await BaseClient.get(
        'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllGIABIEN_IAHByDay?NGAY=${formatDateAPIToday.toString()}',
        onSuccess: (response) {
      final priceModelRes = priceModelFromJson(response.data);
      if (priceModelRes.isEmpty) {
        hideLoading();
        CustomSnackbar.snackBar('error',
            'Không có dữ liệu giá biên ngày ${formatDateAPIToday.toString()}');
      } else {
        for (final e in priceModelRes) {
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
        }

        BaseClient.get(
          'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllGIABIEN_IAHByDay?NGAY=${formatDateAPITomorrow.toString()}',
          onSuccess: (response) {
            final priceModelRes1 = priceModelFromJson(response.data);
            if (priceModelRes1.isEmpty) {
              hideLoading();
            } else {
              for (final e in priceModelRes1) {
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
              }
            }
            hideLoading();
            update();
          },
        );
      }
    });
  }
}
