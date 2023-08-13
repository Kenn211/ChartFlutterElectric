import 'package:get/get.dart';
import '../../core.dart';
import '../base_controller.dart';

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
    for (final i in _dataCongSuat) {
      if (i.idtb == id) {
        _displayCS.value = i.congsuat;
        _displayNameTM.value = i.tentb;
      }
    }
  }
}
