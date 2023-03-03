import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

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
  final Map<String, dynamic> listFactory = {
    'Nhà máy': 0,
  };
  final _dropdownvalueFactory = 'Nhà máy'.obs;
  String get dropdownvalueFactory => _dropdownvalueFactory.value;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchListFatory();
    });
    super.onInit();
  }

  void setValueFactory(String? valueFactory) {
    _dropdownvalueFactory.value = valueFactory!;
  }

  Future<void> fetchListFatory() async {
    showLoading();
    await BaseClient.get(
      'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_DONVIByID?UNITID=-1&UNIT_NAME=',
      onSuccess: (response) {
        List<ListFactoryOutputModel> dataFactoryRespon =
            listFactoryOutputModelFromJson(response.data);
        for (var e in dataFactoryRespon) {
          listFactory.addAll({e.unitName: e.unitid});
        }
        hideLoading();
        update();
      },
    );
  }

  void getDisplayRevenue() async {
    if (dropdownvalueFactory == 'Nhà máy') {
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      await fetchRevenue().whenComplete(() => hideLoading());
    }
  }

  Future<void> fetchRevenue() async {
    _dataRcan.value = [];
    _dataRbp.value = [];
    _dataRcon.value = [];
    _dataRdt.value = [];
    _dataRdu.value = [];
    _dataRsmp.value = [];

    await BaseClient.get(
        "http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllTHANHTOAN_HANGNGAYByDay?NGAY=${formatDateAPIToday.toString()}&UNITID=${listFactory[_dropdownvalueFactory.value]}",
        onSuccess: (response) {
      RevenueModel? revenueModelRes = revenueModelFromJson(response.data);

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

        _thanhToanIII.value = revenueModelRes.thanhToanDichVuDuPhong.toString();

        _thanhToanIV.value = revenueModelRes.thanhToanKhac.toString();

        _sumPay.value = revenueModelRes.tong.toString();
      }
      update();
    });
  }
}
