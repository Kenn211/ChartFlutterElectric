import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/models/drawer/output/output_model.dart';

class MarginalPriceController extends BaseController {
  final listDataChart = <PriceModel>[];

  Future<void> priceAPI() async {
    var response = await http.get(
      Uri.parse('https://mocki.io/v1/3068ee90-719f-41fb-9f88-92bfbd45b1d0'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      OutputModel dataChart = OutputModel.fromJson({'results': data});

      for (var e in dataChart.results) {
        listDataChart.add(PriceModel(
            ID_NODE: e.ID_NODE,
            CHUKY: e.CHUKY,
            GIATRI: e.GIATRI,
            NGAY: e.NGAY,
            TO_MAY: e.TO_MAY));
      }
    } else {
      print('a');
    }
  }

  @override
  void onInit() async {
    await priceAPI();
    listDataChart;
    print(listDataChart.length);
  }

  // Future<void> fetchPriceData() async {
  //   final response = await http.get(
  //       Uri.parse("https://mocki.io/v1/3068ee90-719f-41fb-9f88-92bfbd45b1d0"));

  //   if (response.statusCode == 200) {
  //     PriceModel _priceModel = PriceModel.fromJson(jsonDecode(response.body));

  //     listDataChart.add(PriceModel(
  //         cHUKY: _priceModel.cHUKY,
  //         gIATRI: _priceModel.gIATRI,
  //         iDNODE: _priceModel.iDNODE,
  //         nGAY: _priceModel.nGAY,
  //         tOMAY: _priceModel.tOMAY));
  //     print(response.body);
  //   } else {
  //     print('a');
  //   }
  // }
}
