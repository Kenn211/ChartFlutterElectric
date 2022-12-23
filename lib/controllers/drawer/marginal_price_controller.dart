import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/models/drawer/marginal_price/chart_data.dart';
import 'package:test_chart/models/drawer/marginal_price/marginal_price_model.dart';

class MarginalPriceController extends BaseController {
  List<ChartData> dataColumnChart = <ChartData>[].obs;

  Future<void> fetchPriceData() async {
    final response = await http.get(
        Uri.parse("https://mocki.io/v1/3068ee90-719f-41fb-9f88-92bfbd45b1d0"));

    if (response.statusCode == 200) {
      List<PriceModel> _priceModel = priceModelFromJson(response.body);

      _priceModel.forEach((e) =>
          dataColumnChart.add(ChartData(x: 'Chu kỳ ${e.chuky}', y: e.giatri)));
    } else {
      print('a');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchPriceData();
    print('a');
  }
}
