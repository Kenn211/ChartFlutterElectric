import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class SourcePlanController extends BaseController {
  //Categories Factory
  final Map<String, dynamic> listFactory = {
    'Nhà máy': 0,
  };
  final _dropdownvalueFactory = 'Nhà máy'.obs;
  String get dropdownvalueFactory => _dropdownvalueFactory.value;

  //Data response
  final _dataToMayIAH = <ToMay>[].obs;
  RxList<ToMay> get dataToMayIAH => _dataToMayIAH;
  final _dataToMayDAH = <ToMay>[].obs;
  RxList<ToMay> get dataToMayDAH => _dataToMayDAH;

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
    BaseClient.get(
        'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_NHAMAYByID?ID_NM=-1&TEN_NM=',
        onSuccess: (response) {
      List<ListFactoryModel> dataFactoryRespon =
          listFactoryModelFromJson(response.data);
      for (var e in dataFactoryRespon) {
        listFactory.addAll({e.tenNm: e.idNm});
      }
      hideLoading();
      update();
    });
  }

  void getDisplayData() {
    if (dropdownvalueFactory == 'Nhà máy') {
      _dataToMayIAH.value = [];
      _dataToMayDAH.value = [];
      update();
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      fetchPlan();
    }
  }

  Future<void> fetchPlan() async {
    _dataToMayIAH.value = [];
    _dataToMayDAH.value = [];

    await BaseClient.get(
        'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay2?NGAY=${formatDateAPIToday.toString()}&ID_NM=${listFactory[_dropdownvalueFactory.value]}',
        onSuccess: (response) {
      SourcePlanModel planModel = sourcePlanModelFromJson(response.data);

      if (planModel.toMay.isEmpty) {
        hideLoading();
        CustomSnackbar.snackBar('error', 'Không có dữ liệu ngày này');
      } else {
        for (var e in planModel.toMay) {
          _dataToMayIAH.add(e);
        }

        //Get Data DAH
        BaseClient.get(
            'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_DAHByDay2?NGAY=${formatDateAPITomorrow.toString()}&ID_NM=${listFactory[_dropdownvalueFactory.value]}',
            onSuccess: (response) {
          SourcePlanModel planModel1 = sourcePlanModelFromJson(response.data);
          for (var e in planModel1.toMay) {
            _dataToMayDAH.add(e);
          }
          hideLoading();
          update();
        });
      }
    });
  }
}
