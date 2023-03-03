import 'package:get/get.dart';
import 'package:test_chart/controllers/base_controller.dart';
import 'package:test_chart/core.dart';
import 'package:test_chart/routes/helpers/route_helper.dart';

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
        var dataCompany = listLakeModelFromJson(response.data);
        for (var e in dataCompany) {
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
