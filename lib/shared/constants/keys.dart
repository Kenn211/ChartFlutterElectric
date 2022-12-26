import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static const isLogged = 'isLogged';
  static const accessToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const changeLocale = 'changeLocale';
  static const languageCode = 'languageCode';
  static const countryCode = 'countryCode';
  static const provinceCache = 'provinceCache';
  static const salesLocationCache = 'salesLocationCache';
  static const rememberPassword = 'rememberPassword';
  static const cartNoUser = 'cartNoUser';
  static const fontFamily = 'Roboto';
  static double height = MediaQuery.of(Get.context!).size.height;
  static double width = MediaQuery.of(Get.context!).size.width;
  static double statusBarHeight = MediaQuery.of(Get.context!).viewPadding.top;

  // format date
  static String FULL_YEAR_FORMAT = 'dd/MM/yyyy';
  static String FULL_YEAR_FORMAT_WITH_UNIT = 'dd/MM/yyyy hh:mm:ss';

  // timeout
  static const int TIME_OUT_DURATION = 30;

  // tabbar
  static const int SHOP_TABBAR_LENGTH = 4;
  static const int CART_TABBAR_LENGTH = 2;
  static const int HOME_TABBAR_LENGTH = 3;
  static const int MESSAGES_TABBAR_LENGTH = 2;
  static const int PRODUCT_TABBAR_LENGTH = 4;
  static const int VOUCHER_TABBAR_LENGTH = 4;
  static const int SHOP_ACTIVE_HISTORY = 3;
  static const int NEWS_TABBAR_LENGTH = 4;
  static const int ORDER_TABBAR_LENGTH = 7;
  static const int RATING_ORDER_TABBAR_LENGTH = 2;
}
