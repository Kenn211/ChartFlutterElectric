import 'package:get/get.dart';
import '../../core.dart';

import '../base_controller.dart';

class FactoryHomeController extends BaseController {
  final Map<String, dynamic> listFactory = {
    'Nhà máy': 0,
  };
  final _dropdownValueFactory = 'Nhà máy'.obs;
  String get dropdownValueFactory => _dropdownValueFactory.value;

  void setValueFactory(String? value) {
    _dropdownValueFactory.value = value!;
  }

  Future<void> getData() async {
    final home = Get.find<HomeController>();
    await Future.wait(
            [home.getDataLakeLevel(listFactory[_dropdownValueFactory.value])])
        .whenComplete(Get.back);
  }
}
