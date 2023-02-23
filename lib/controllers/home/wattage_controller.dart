import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class WattageController extends BaseController {
  final _dataCongSuat = <DataCongSuat>[].obs;
  RxList<DataCongSuat> get dataCongSuat => _dataCongSuat;

  final _displayCS = 0.0.obs;
  double get displayCS => _displayCS.value;

  final _displayNameTM = 'Toàn nhà máy'.obs;
  String get displayNameTM => _displayNameTM.value;

  @override
  void onInit() {
    super.onInit();
    if (checkArgumentsExist('data')) {
      _dataCongSuat.value = Get.arguments['data'];
      _displayCS.value = _dataCongSuat[0].congsuat;
    }
  }

  void funcDisplayCS(String id) {
    for (var i in _dataCongSuat) {
      if (i.idtb == id) {
        _displayCS.value = i.congsuat;
        _displayNameTM.value = i.tentb;
      }
    }
  }
}
