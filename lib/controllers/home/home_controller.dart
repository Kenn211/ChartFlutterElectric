import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core.dart';
import '../../routes/helpers/route_helper.dart';
import '../base_controller.dart';
import '../biometric/biometric_auth.dart';

class HomeController extends BaseController {
  final _selectedIndex = RxInt(0);
  int get selectedIndex => _selectedIndex.value;

  final _dataCongSuat = <DataCongSuat>[].obs;
  RxList<DataCongSuat> get dataCongSuat => _dataCongSuat;

  final _displayDataCS = 0.0.obs;
  double get displayDataCS => _displayDataCS.value;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getDataCongSuat();
    });
    super.onInit();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void handleLogout() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () async {
      await RouterHelper.onLogout();
      hideLoading();
    });
  }

  Future<void> handleCheckBiometric() async {
    final authenBiometric = await BiometricAuth().authenticate();
    if (authenBiometric) {}
  }

  void setDrawerIndex(int index) {
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

  Future<void> getDataCongSuat() async {
    _dataCongSuat.value = [];
    await BaseClient.get(
        'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/CONGSUATPHAT_NHAMY_GET?MaDV=G25600',
        onSuccess: (response) {
      _dataCongSuat.value = dataCongSuatFromJson(response.data);
      _displayDataCS.value = _dataCongSuat[0].congsuat;
    });
    update();
  }

  void toSelectCompany() {
    RouterHelper.getSelectCompany();
  }

  Future<void> getDataLakeLevel(int id) async {
    showLoading();
    await Future.delayed(const Duration(seconds: 2), hideLoading);
    // try {
    //   await BaseClient()
    //       .get(
    //           'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/HOCHUA_THUYVAN_GET?ID_HO=55&NGAY=2022-12-27&NAM=2022')
    //       .then((value) {})
    //       .whenComplete(() {});
    // } catch (_) {}
  }
}
