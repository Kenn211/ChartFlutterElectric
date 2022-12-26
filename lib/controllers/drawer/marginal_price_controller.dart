import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/models/drawer/marginal_price/marginal_price_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class MarginalPriceController extends BaseController {
  final _dataChartNorth = <ChartData>[].obs;
  RxList<ChartData> get dataChartNorth => _dataChartNorth;

  final _dataChartCentral = <ChartData>[].obs;
  RxList<ChartData> get dataChartCentral => _dataChartCentral;

  final _dataChartSouth = <ChartData>[].obs;
  RxList<ChartData> get dataChartSouth => _dataChartSouth;

  final _dataChartNation = <ChartData>[].obs;
  RxList<ChartData> get dataChartNation => _dataChartNation;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchPriceData() async {
    showLoading();
    try {
      await http
          .get(
        Uri.parse(
            'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllPHUTAI_DAHByDay?NGAY=${dateSelected}'),
      )
          .then((value) {
        if (value.statusCode == 200) {
          List<PriceModel> _priceModel = priceModelFromJson(value.body);
          if (_priceModel.length == 0) {
            hideLoading();
            CustomSnackbar.snackBar('error'.tr, 'Không có dữ liệu ngày này');
          } else {
            _priceModel.forEach((e) {
              if (e.idNode == 1) {
                _dataChartNorth.add(ChartData(x: '${e.chuky}', y: e.giatri));
              } else if (e.idNode == 2) {
                _dataChartCentral.add(ChartData(x: '${e.chuky}', y: e.giatri));
              } else if (e.idNode == 3) {
                _dataChartSouth.add(ChartData(x: '${e.chuky}', y: e.giatri));
              } else if (e.idNode == 150) {
                _dataChartNation.add(ChartData(x: '${e.chuky}', y: e.giatri));
              }
            });
            hideLoading();
            CustomSnackbar.snackBar('Thành công', 'Dữ liệu trả về thành công');
          }
        } else {
          print('a');
        }
      });

      // await http
      //     .get(
      //   Uri.parse(
      //       'http://103.78.88.74:207/api/API_GIABIEN_IAH/GetAllPHUTAI_IAHByDay?NGAY=2021-05-09'),
      // )
      //     .then((value) {
      //   if (value.statusCode == 200) {
      //     List<PriceModel> _priceModel1 = priceModelFromJson(value.body);

      //     _priceModel1.forEach((e) {
      //       _dataChartCentral
      //           .add(ChartData(x: 'Chu kỳ ${e.chuky}', y1: e.giatri));

      //       print(_dataChartCentral.map((e) => e.y1));
      //     });
      //   } else {
      //     print('a');
      //   }
      // });
    } catch (e) {
      print(e);
    }
    hideLoading();
    update();
  }
}
