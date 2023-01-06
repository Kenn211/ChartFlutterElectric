import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/models/drawer/revenue/chart_revenue.dart';

class RevenueController extends BaseController {
  final _dataRcan = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRcan => _dataRcan;

  final _dataRsmp = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRsmp => _dataRsmp;

  final _dataRbp = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRbp => _dataRbp;

  final _dataRcon = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRcon => _dataRcon;

  final _dataRdu = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRdu => _dataRdu;

  final _dataRdt = <ChartRevenue>[].obs;
  RxList<ChartRevenue> get dataRdt => _dataRdt;
}
