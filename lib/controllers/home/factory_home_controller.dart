import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';

class FactoryHomeController extends BaseController {
  final Map<String, dynamic> listFactory = {
    'Nhà máy': 0,
  };
  final _dropdownValueFactory = 'Nhà máy'.obs;
  String get dropdownValueFactory => _dropdownValueFactory.value;

  @override
  void onInit() {
    super.onInit();
  }

  void setValueFactory(String? value) {
    _dropdownValueFactory.value = value!;
  }

  Future<void> getData() async {
    final home = Get.find<HomeController>();
    await Future.wait(
            [home.getDataLakeLevel(listFactory[_dropdownValueFactory.value])])
        .whenComplete(() {
      Get.back();
    });
  }
}
