import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

class HomeController extends BaseController {
  final _selectedIndex = RxInt(0);
  int get selectedIndex => _selectedIndex.value;

  final _dataCongSuat = <DataCongSuat>[].obs;
  RxList<DataCongSuat> get dataCongSuat => _dataCongSuat;

  final _displayDataCS = 0.0.obs;
  double get displayDataCS => _displayDataCS.value;

  @override
  void onInit() {
    super.onInit();
    fetchDataCongSuat();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void handleLogout() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      RouterHelper.onLogout();
      hideLoading();
    });
  }

  void setNavigationBarIndex(int index) {
    switch (index) {
      case 1:
        Get.toNamed(Routes.tonnageScreen);
        break;
      case 2:
        Get.toNamed(Routes.marginalPriceScreen);
        break;
      case 3:
        Get.toNamed(Routes.outputScreen);
        break;
      case 4:
        Get.toNamed(Routes.hydrologicalScreen);
        break;
      case 5:
        Get.toNamed(Routes.revenueScreen);
        break;
      case 6:
        Get.toNamed(Routes.sourcePlanScreen);
        break;
      case 7:
        handleLogout();
        break;
      default:
    }
  }

  Future<void> fetchDataCongSuat() async {
    try {
      _dataCongSuat.value = [];
      BaseClient()
          .get(
              'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/CONGSUATPHAT_NHAMY_GET?MaDV=G25600')
          .then((value) {
        _dataCongSuat.value = dataCongSuatFromJson(value.body);
        _displayDataCS.value = _dataCongSuat[0].congsuat;
        update();
      });
    } catch (_) {}
  }
}
