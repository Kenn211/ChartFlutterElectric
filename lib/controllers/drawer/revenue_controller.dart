import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:http/http.dart' as http;

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

  final _thanhToanI = ''.obs;
  RxString get thanhToanI => _thanhToanI;

  final _thanhToanI1 = ''.obs;
  RxString get thanhToanI1 => _thanhToanI1;

  final _thanhToanI2 = ''.obs;
  RxString get thanhToanI2 => _thanhToanI2;

  final _thanhToanI3 = ''.obs;
  RxString get thanhToanI3 => _thanhToanI3;

  final _thanhToanI4 = ''.obs;
  RxString get thanhToanI4 => _thanhToanI4;

  final _thanhToanII = ''.obs;
  RxString get thanhToanII => _thanhToanII;

  final _thanhToanIII = ''.obs;
  RxString get thanhToanIII => _thanhToanIII;

  final _thanhToanIV = ''.obs;
  RxString get thanhToanIV => _thanhToanIV;

  final _sumPay = ''.obs;
  RxString get sumPay => _sumPay;

  //Categories Factory
  List<ListFactoryOutputModel> dataFactory = [];
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
    fetchListFatory();
    super.onInit();
  }

  void setValueFactory(String? valueFactory) {
    _dropdownvalueFactory.value = valueFactory!;
  }

  Future<void> fetchListFatory() async {
    try {
      indexFactory = 0;
      listFactory = ['Nhà máy'];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_DONVIByID?UNITID=-1&UNIT_NAME='))
          .then((value) {
        List<ListFactoryOutputModel> dataFactoryRespon =
            listFactoryOutputModelFromJson(value.body);
        for (var e in dataFactoryRespon) {
          listFactory.add(e.unitName);
          dataFactory.add(e);
        }
      });
    } catch (e) {
      debugPrintStack(label: e.toString());
    }
    hideLoading();
    update();
  }

  void getDisplayRevenue() {
    indexFactory = 0;
    if (dropdownvalueFactory == 'Nhà máy') {
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      for (var e in dataFactory) {
        if (dropdownvalueFactory == e.unitName) {
          indexFactory = e.unitid;
          fetchRevenue();
        }
      }
    }
  }

  Future<void> fetchRevenue() async {
    try {
      _dataRcan.value = [];
      _dataRbp.value = [];
      _dataRcon.value = [];
      _dataRdt.value = [];
      _dataRdu.value = [];
      _dataRsmp.value = [];

      await http
          .get(
        Uri.parse(
            "http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllTHANHTOAN_HANGNGAYByDay?NGAY=${formatDateAPIToday.toString()}&UNITID=${indexFactory.toInt()}"),
      )
          .then((value) {
        RevenueModel? revenueModelRes = revenueModelFromJson(value.body);

        if (revenueModelRes == null) {
        } else {
          for (var e in revenueModelRes.rcan!) {
            _dataRcan.add(ChartRevenue(x: e!.chuKy.toString(), rcan: e.giaTri));
          }

          for (var e in revenueModelRes.rbp!) {
            _dataRbp.add(ChartRevenue(x: e!.chuKy.toString(), rbp: e.giaTri));
          }

          for (var e in revenueModelRes.rcon!) {
            _dataRcon.add(ChartRevenue(x: e!.chuKy.toString(), rcon: e.giaTri));
          }

          for (var e in revenueModelRes.rdt!) {
            _dataRdt.add(ChartRevenue(x: e!.chuKy.toString(), rdt: e.giaTri));
          }

          for (var e in revenueModelRes.rdu!) {
            _dataRdu.add(ChartRevenue(x: e!.chuKy.toString(), rdu: e.giaTri));
          }

          for (var e in revenueModelRes.rsmp!) {
            _dataRsmp.add(ChartRevenue(x: e!.chuKy.toString(), rsmp: e.giaTri));
          }

          _thanhToanI.value =
              revenueModelRes.thanhToanDienNangThiTruong.toString();

          _thanhToanI1.value =
              revenueModelRes.thanhToanTinhTheoGiaDienNangThiTruong.toString();

          _thanhToanI2.value =
              revenueModelRes.thanhToanTinhTheoGiaChao.toString();

          _thanhToanI3.value =
              revenueModelRes.thanhToanChoPhanSanLuongPhatTangThem.toString();

          _thanhToanI4.value =
              revenueModelRes.thanhToanSanLuongSaiKhac.toString();

          _thanhToanII.value =
              revenueModelRes.thanhToanCongSuatThitruong.toString();

          _thanhToanIII.value =
              revenueModelRes.thanhToanDichVuDuPhong.toString();

          _thanhToanIV.value = revenueModelRes.thanhToanKhac.toString();

          _sumPay.value = revenueModelRes.tong.toString();
        }
      });
    } catch (e) {
      debugPrintStack();
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      hideLoading();
    });
    update();
  }
}
