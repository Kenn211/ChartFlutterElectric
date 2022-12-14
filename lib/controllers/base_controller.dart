import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/shared/helpers/function_helper.dart';

import '/services/storage/storage_service.dart';
import '/shared/app_shared.dart';

abstract class BaseController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> get refreshIndicatorKey =>
      _refreshIndicatorKey;

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final setStorage = Get.find<StorageService>();

  final _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final _userNameController = TextEditingController(text: 'Vanhvanh');
  TextEditingController get userNameController => _userNameController;

  final _passwordController = TextEditingController(text: 'Admin123');
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

  // void onChangeDate() {
  //   Helpers.closeKeyboard();
  //   FunctionHelper.showDate(
  //     Helpers.dateExtension.dateToDateOnly(DateTime.now()),
  //     onConfirm: (date) {
  //       _dob.value = Helpers.dateExtension.dateToDateOnly(date);
  //       _dobController.text = _dob.value;
  //     },
  //   );
  // }

  // void onChangeGender(Gender? value) {
  //   _groupValue.value = value!;
  // }

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

  @override
  void onInit() async {
    if (await hasLoggedIn()) {
      _isLoggedIn.value = true;
      update();
    }
    super.onInit();
  }

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
