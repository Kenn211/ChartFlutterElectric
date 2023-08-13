import 'package:get/get.dart';

import '../../core.dart';
import '../../routes/helpers/route_helper.dart';
import '../base_controller.dart';

class SelectCompanyController extends BaseController {
  final Map<String, dynamic> listCompany = {
    'Công ty': 0,
  };
  final _dropdownValueCompany = 'Công ty'.obs;
  String get dropdownValueCompany => _dropdownValueCompany.value;

  void setValueCompany(String? value) {
    _dropdownValueCompany.value = value!;
  }

  Future<void> fetchListCompany() async {
    await BaseClient.get(
      'http://appapi.quanlycongviec-nldc.vn/api/API_GIABIEN_IAH/GetAllHT_HOCHUAByID?ID_HO=-1&TEN_HO=%27%27',
      onSuccess: (response) {
        final dataCompany = listLakeModelFromJson(response.data);
        for (final e in dataCompany) {
          listCompany.addAll({e.tenHo: e.idHo});
        }
        hideLoading();
        update();
      },
    );
  }

  void submitSelectCompany() {
    RouterHelper.getOffUntil();
  }
}
