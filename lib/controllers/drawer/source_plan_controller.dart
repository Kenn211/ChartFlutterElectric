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
      BaseClient()
          .get(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_NHAMAYByID?ID_NM=-1&TEN_NM=')
          .then((value) {
        List<ListFactoryModel> dataFactoryRespon =
            listFactoryModelFromJson(value.body);
        for (var e in dataFactoryRespon) {
          listFactory.addAll({e.tenNm: e.idNm});
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
    try {
      _dataToMayIAH.value = [];
      _dataToMayDAH.value = [];

      await BaseClient()
          .get(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay2?NGAY=${formatDateAPIToday.toString()}&ID_NM=${listFactory[_dropdownvalueFactory.value]}')
          .then((value) {
        SourcePlanModel planModel = sourcePlanModelFromJson(value.body);

        if (planModel.toMay.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar('error', 'Không có dữ liệu ngày này');
        } else {
          for (var e in planModel.toMay) {
            _dataToMayIAH.add(e);
          }

          //Get Data DAH
          BaseClient()
              .get(
                  'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_DAHByDay2?NGAY=${formatDateAPITomorrow.toString()}&ID_NM=${listFactory[_dropdownvalueFactory.value]}')
              .then((value) {
            SourcePlanModel planModel1 = sourcePlanModelFromJson(value.body);
            for (var e in planModel1.toMay) {
              _dataToMayDAH.add(e);
            }
            CustomSnackbar.showSuccessToast('Thành công',
                'Dữ liệu kế hoạch nhà máy ${dropdownvalueFactory.toString()}');
          });
          update();
        }
      });
    } catch (e) {
      debugPrintStack();
    }
    hideLoading();
  }
}
