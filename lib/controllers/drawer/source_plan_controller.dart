import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:test_chart/models/drawer/source_plan/list_factory_model.dart';
import 'package:test_chart/models/drawer/source_plan/source_plan_model.dart';
import 'package:test_chart/shared/widgets/custom_snackbar.dart';

class SourcePlanController extends BaseController with StateMixin {
  //Categories Factory
  List<ListFactoryModel> dataFactory = [];
  int indexFactory = 0;
  List<String> listFactory = ['Nhà máy'];
  String dropdownvalueFactory = 'Nhà máy';

  //Data respon
  var _dataToMayIAH = <ToMay>[].obs;
  RxList<ToMay> get dataToMayIAH => _dataToMayIAH;

  //Data respon
  var _dataToMayDAH = <ToMay>[].obs;
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

  Future<void> fetchListFatory() async {
    try {
      indexFactory = 0;
      listFactory = ['Nhà máy'];
      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_NHAMAYByID?ID_NM=-1&TEN_NM='))
          .then((value) {
        List<ListFactoryModel> _dataFactory =
            listFactoryModelFromJson(value.body);
        _dataFactory.forEach((e) {
          listFactory.add(e.tenNm);
          dataFactory.add(e);
        });
      });
    } catch (e) {
      print(e);
    }
    hideLoading();
    update();
  }

  void getDisplayData() {
    indexFactory = 0;
    if (dropdownvalueFactory == 'Nhà máy') {
      _dataToMayIAH.value = [];
      _dataToMayDAH.value = [];
      update();
      CustomSnackbar.snackBar('error', 'Vui lòng chọn nhà máy');
    } else if (dropdownvalueFactory != 'Nhà máy') {
      showLoading();
      dataFactory.forEach((e) {
        if (dropdownvalueFactory == e.tenNm) {
          indexFactory = e.idNm;
          fetchPlan();
          print(indexFactory);
        }
      });
    }
  }

  Future<void> fetchPlan() async {
    try {
      _dataToMayIAH.value = [];
      _dataToMayDAH.value = [];

      await http
          .get(Uri.parse(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_IAHByDay2?NGAY=${formatDateAPITomorrow.toString()}&ID_NM=${indexFactory.toInt()}'))
          .then((value) {
        final _planModel = sourcePlanModelFromJson(value.body);

        if (_planModel.toMay.isEmpty) {
          hideLoading();
          CustomSnackbar.snackBar('error', 'Không có dữ liệu ngày này');
        } else {
          _planModel.toMay.forEach((e) {
            _dataToMayIAH.add(e);
          });

          //Get Data DAH
          http
              .get(Uri.parse(
                  'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllKHVH_DAHByDay2?NGAY=${formatDateAPIToday.toString()}&ID_NM=${indexFactory.toInt()}'))
              .then((value) {
            final _planModel1 = sourcePlanModelFromJson(value.body);
            _planModel1.toMay.forEach((e) {
              _dataToMayDAH.add(e);
            });
            update();
          });
        }
      });
    } catch (e) {
      print(e);
    }
    hideLoading();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
