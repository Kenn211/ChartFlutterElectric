import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/models/drawer/hydrological/data_lake_model.dart';
import 'package:test_chart/models/drawer/hydrological/lake_list_model.dart';

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

  @override
  void onReady() {
    showLoading();
  }

  @override
  void onInit() {
    fetchListLake();
    super.onInit();
  }

  //Categories Lake
  List<ListLakeModel> dataLake = [];
  int indexLake = 0;
  List<String> listLake = ['Nhà máy'];
  String dropdownvalueLake = 'Nhà máy';

  Future<void> fetchListLake() async {
    try {
      http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_HOCHUAByID?ID_HO=-1&TEN_HO=%27%27'))
          .then((value) {
        dataLake = listLakeModelFromJson(value.body);
        for (var e in dataLake) {
          listLake.add(e.tenHo);
        }
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
    hideLoading();
  }

  void getDisplayData() {
    indexLake = 0;
    if (dropdownvalueLake == 'Nhà máy') {
      _dataGHDuoi.value = [];
      _dataGHTren.value = [];
      _dataKHNam.value = [];
      _dataMnc.value = [];
      _dataMndbt.value = [];
      _dataTTNam.value = [];
      _dataTTNamAgo.value = [];
      update();
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueLake != 'Nhà máy') {
      showLoading();
      for (var e in dataLake) {
        if (dropdownvalueLake == e.tenHo) {
          indexLake = e.idHo;
          fetchLake();
        }
      }
    }
  }

  Future<void> fetchLake() async {
    try {
      _dataGHDuoi.value = [];
      _dataGHTren.value = [];
      _dataKHNam.value = [];
      _dataMnc.value = [];
      _dataMndbt.value = [];
      _dataTTNam.value = [];
      _dataTTNamAgo.value = [];

      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/HOCHUA_THUYVAN_GET?ID_HO=$indexLake&NGAY=2023-01-27&NAM=2022'))
          .then((value) {
        DataLakeModel dataLakeRes = dataLakeModelFromJson(value.body);
        for (var e in dataLakeRes.mucnuocChet) {
          _dataMnc
              .add(ChartHydrological(x: e.waterDay.toString(), mnc: e.value));
        }
        for (var e in dataLakeRes.mucnuocDangbinhthuong) {
          _dataMndbt.add(ChartHydrological(x: e.waterDay, mndbt: e.value));
        }
        for (var e in dataLakeRes.mucnuocGioihanduoi) {
          _dataGHDuoi.add(ChartHydrological(x: e.waterDay, ghDuoi: e.value));
        }
        for (var e in dataLakeRes.mucnuocGioihantren) {
          _dataGHTren.add(ChartHydrological(x: e.waterDay, ghTren: e.value));
        }
        for (var e in dataLakeRes.mucnuocKehoachnam) {
          _dataKHNam.add(ChartHydrological(x: e.waterDay, khNam: e.value));
        }
        for (var e in dataLakeRes.mucnuocNamhientai) {
          _dataTTNam.add(ChartHydrological(x: e.waterDay, ttNam: e.value));
        }
        for (var e in dataLakeRes.mucnuocNamquakhu) {
          _dataTTNamAgo
              .add(ChartHydrological(x: e.waterDay, ttNamAgo: e.value));
        }
        for (var e in dataLakeRes.mucnuocDangbinhthuong) {
          _dataMndbt.add(ChartHydrological(x: e.waterDay, mndbt: e.value));
        }
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
    hideLoading();
  }
}
