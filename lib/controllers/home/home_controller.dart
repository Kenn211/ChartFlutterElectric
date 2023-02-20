import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

class HomeController extends BaseController {
  final _selectedIndex = RxInt(0);
  int get selectedIndex => _selectedIndex.value;

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
}
