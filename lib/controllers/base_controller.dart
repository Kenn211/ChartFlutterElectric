import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/shared/helpers/function_helper.dart';
import 'package:intl/intl.dart';

import '/services/storage/storage_service.dart';
import '/shared/app_shared.dart';

abstract class BaseController extends GetxController {
  //Table
  TableRow buildRow(List<String> cells,
      {bool isHeader = false, bool isCate = false, double height = 40}) {
    final style = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontSize: 15,
    );

    return TableRow(
        children: cells
            .map((cell) => Container(
                  color: isHeader
                      ? Colors.blue.shade200
                      : isCate
                          ? const Color.fromARGB(255, 216, 214, 214)
                          : Colors.white,
                  alignment: Alignment.center,
                  height: height,
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                ))
            .toList());
  }

  //DateTime picker
  Rx<DateTime> selectedDateTime = DateTime.now().obs;
  String formatDateAPIToday = '';
  String formatDateAPITomorrow = '';

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDateTime.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        initialEntryMode: DatePickerEntryMode.input,
        initialDatePickerMode: DatePickerMode.year,
        errorFormatText: 'Định dạng phải là tháng/ngày/năm',
        cancelText: 'ĐÓNG',
        helpText: 'Chọn ngày');
    if (pickedDate != null && pickedDate != selectedDateTime.value) {
      selectedDateTime.value = pickedDate;
      formatDateAPIToday =
          DateFormat("yyyy-MM-dd").format(selectedDateTime.value);
      formatDateAPITomorrow = DateFormat("yyyy-MM-dd")
          .format(selectedDateTime.value.add(const Duration(days: 1)));
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final setStorage = Get.find<StorageService>();

  // final _scrollController = ScrollController();
  // ScrollController get scrollController => _scrollController;

  final _userNameController = TextEditingController();
  TextEditingController get userNameController => _userNameController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final _rePasswordController = TextEditingController();
  TextEditingController get rePasswordController => _rePasswordController;

  final _oldPasswordController = TextEditingController();
  TextEditingController get oldPasswordController => _oldPasswordController;

  final _dobController = TextEditingController();
  TextEditingController get dobController => _dobController;

  final _phoneController = TextEditingController(text: '0336381125');
  TextEditingController get phoneController => _phoneController;

  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final _pincodeController = TextEditingController();
  TextEditingController get pincodeController => _pincodeController;

  final _responseController = TextEditingController();
  TextEditingController get responseController => _responseController;

  final _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final _companyNameController = TextEditingController();
  TextEditingController get companyNameController => _companyNameController;

  final _companyAddressController = TextEditingController();
  TextEditingController get companyAddressController =>
      _companyAddressController;

  final _taxCodeController = TextEditingController();
  TextEditingController get taxCodeController => _taxCodeController;

  final _citizenIdController = TextEditingController(text: '001 195 031 100');
  TextEditingController get citizenIdController => _citizenIdController;

  final _addressController = TextEditingController(
      text: 'Quan Hoa - Nhan Chinh - Thanh Xuan - Ha Noi');
  TextEditingController get addressController => _addressController;

  final _userName = ''.obs;
  RxString get userName => _userName;

  final _companyName = ''.obs;
  RxString get companyName => _companyName;

  final _companyAddress = ''.obs;
  RxString get companyAddress => _companyAddress;

  final _taxCode = ''.obs;
  RxString get taxCode => _taxCode;

  final _password = ''.obs;
  RxString get password => _password;

  final _rePassword = ''.obs;
  RxString get rePassword => _rePassword;

  final _oldPassword = ''.obs;
  RxString get oldPassword => _oldPassword;

  final _dob = ''.obs;
  RxString get dob => _dob;

  final _phone = ''.obs;
  RxString get phone => _phone;

  final _email = ''.obs;
  RxString get email => _email;

  final _citizenId = ''.obs;
  RxString get citizenId => _citizenId;

  final _address = ''.obs;
  RxString get address => _address;

  final _search = ''.obs;
  RxString get search => _search;

  final _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  // final _groupValue = Gender.male.obs;
  // Rx<Gender> get groupValue => _groupValue;

  final _checked = false.obs;
  RxBool get checked => _checked;

  final _selected = true.obs;
  RxBool get selected => _selected;

  final _hasFocus = false.obs;
  RxBool get hasFocus => _hasFocus;

  late TabController tabController;
  late ImageProvider<Object> oBackground;

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void onChecked(bool? value) {
    if (value != null) _checked.value = value;
    update();
  }

  void onSelected(bool? value) {
    if (value != null) _selected.value = value;
    update();
  }

  // void onFocusChange([bool? close]) {
  //   if (close == true) {
  //     searchController.text = '';
  //     searchController.clear();
  //     search.value = '';
  //   }
  //   if (!_hasFocus.value || close != null) {
  //     if (close != null) {
  //       Helpers.closeKeyboard();
  //     }
  //     _hasFocus.value = !_hasFocus.value;
  //   }
  //   update();
  // }

  void onSearchChangedText(String search) {
    _search.value = search;
    update();
  }

  bool checkArgumentsExist(String value) {
    if (Get.arguments != null && Get.arguments[value] != null) {
      return true;
    }
    return false;
  }

  void showLoading([String? message]) {
    FunctionHelper.showLoading(message);
  }

  void hideLoading() {
    FunctionHelper.hideLoading();
  }

  Future<String> currentLocaleLanguage() async {
    final SharedPreferences storage = await prefs;
    final key = storage.getString(Constants.languageCode);
    final languageCode = (key == 'vi' || key == null) ? 'vi-VN' : 'en-EN';
    return languageCode;
  }

  /// Check isLoggedIn on Screen/Controller
  final _isLoggedIn = RxBool(false);
  bool get isLoggedIn => _isLoggedIn.value;

  Future<bool> hasLoggedIn() async {
    final SharedPreferences storage = await prefs;
    final storageValue = storage.getBool(Constants.isLogged);
    final hasLogedIn =
        (storageValue != null && storageValue == true) ? true : false;
    return hasLogedIn;
  }

  // features developing
  void featureDeveloping() {
    CustomSnackbar.snackBar('error', 'Tính năng đang phát triển');
  }

  // @override
  // void onInit() async {
  //   if (await hasLoggedIn()) {
  //     _isLoggedIn.value = true;
  //     update();
  //   }
  //   super.onInit();
  // }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _oldPasswordController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _pincodeController.dispose();
    _responseController.dispose();
    _searchController.dispose();
    tabController.dispose();
    _citizenIdController.dispose();
    _addressController.dispose();
  }

  @override
  void onClose() {
    _isLoading.value = false;
    super.onClose();
  }
}
