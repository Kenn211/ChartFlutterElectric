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
  static const customerIdClient = 'customerIdClient';
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

  // api connect
  static const user = 'api/user/customers';
  static const catalog = 'api/custom-catalog';
  static const banner = 'api/banner';
  static const categoriesbase = 'api/categories-base';
  static const supportArtilce = 'api/support-article';
  static const userAddress = 'api/user-address';
  static const salesLocation = 'api/sales-location';
  static const product = 'api/product';
  static const profileNews = 'api/posts';
  static const customCart = 'api/custom-cart';
  static const customer = 'api/customer';
  static const promotion = 'api/custom-promotion/customers';
  static const customOrder = 'api/custom-order/customer';
  static const productReview = 'api/product-review';

  static const String userLogin = 'api/user/login';
  static const String userRefreshToken = 'connect/token';

  static const String forgotPasswordSendOtp =
      '${Constants.user}/forgot-password/send-otp';
  static const String forgotPasswordVerifyOtp =
      '${Constants.user}/forgot-password/verify-otp';
  static const String forgotPasswordUpdate =
      '${Constants.user}/forgot-password';

  static const String registerSendOtp = '${Constants.user}/register/send-otp';
  static const String registerVerifyOtp =
      '${Constants.user}/register/verify-otp';
  static const String register = '${Constants.user}/register';

  static const String userProfile = '${Constants.user}/profile';
  static const String userChangeProfile = '${Constants.user}/change-profile';
  static const String userSetAvatar = 'api/assets';
  static const String userChangePassword = '${Constants.user}/change-password';

  static const String changePhoneSendOtp =
      '${Constants.user}/change-phone/send-otp';
  static const String changePhoneVerifyOtp =
      '${Constants.user}/change-phone/verify-otp';

  static const String changeEmailSendOtp =
      '${Constants.user}/change-email/send-otp';
  static const String changeEmailVerifyOtp =
      '${Constants.user}/change-email/verify-otp';

  static const String getCategories =
      '${Constants.catalog}/customer/categories';
  static const String getHomeBanner = '${Constants.banner}/home-banner';
  static const String getAddressLocation =
      '${Constants.categoriesbase}/customer/search';
  static const String getUserHistorySearch =
      'api/user-action-log/getall'; // Get user history search
  static const String addUserHistorySearch =
      'api/user-action-log'; // Add log when user search & press to product

  static const String getUserAddress = '${Constants.userAddress}/search';
  static const String createUserNewAddress =
      '${Constants.userAddress}/addresses';
  static const String updateUserAddress = '${Constants.userAddress}/addresses';
  static const String deleteUserAddress =
      '${Constants.userAddress}/addresses?id=';
  static const String getSalesLocationByAddress =
      '${Constants.salesLocation}/by-address';

  static const String getProduct =
      '${Constants.product}/customer/search'; // List of Product
  static const String getProductDetail =
      '${Constants.product}/customer'; // Product detail
  static const String getProductPriceRange =
      '${Constants.customer}/price-range/search'; // Product price range (product/variants)
  static const String getProductProperties =
      '${Constants.product}/customer/properties'; // Get product properties

  static const String getProfileNews =
      '${Constants.profileNews}/customer'; // About us/Terms of services/etc

  static const String addProductToCart =
      '${Constants.customCart}/add-product'; // Add product to cart
  static const String getListCart =
      '${Constants.customCart}/carts'; // Get list cart
  static const String updateProductInCart =
      '${Constants.customCart}/update-product'; // Update product quantity in cart
  static const String deleteProductItemInCart =
      '${Constants.customCart}/delete-product'; // Delete item in cart
  static const String processCheckItemInCart =
      '${Constants.customCart}/calculator'; // Process check item in cart

  static const String getShipmentMethods =
      '${Constants.customCart}/cart-order/shipments'; // List of shipment methods
  static const String getCartBuyShipping =
      '${Constants.customCart}/cart-order/cart-by-shipping'; // get cart buy shipping
  static const String getCouponsByCart =
      '${Constants.customCart}/cart-order/coupons-by-carts'; // get coupons buy cart
  static const String getCartByCoupons =
      '${Constants.customCart}/cart-order/cart-by-coupons'; // get cart buy coupons
  static const String getStoreInfo =
      '${Constants.product}/customer/store?storeId='; // Store information

  static const String getCustomerSupportCategories =
      '${Constants.categoriesbase}/customer/search'; // Categories of customer support
  static const String getSupportArticleForCustomer =
      '${Constants.supportArtilce}/customer'; // FAQ of Customer support

  static const String getStorePromotions =
      '${Constants.promotion}/store-promotions'; // Store voucher list <storeId, take>
  static const String getHomePromotions =
      '${Constants.promotion}/platform-promotions'; // Store voucher list <storeId, take>
  static const String saveStorePromotions =
      '${Constants.promotion}/user-discount'; // Store voucher save
  static const String saveMultiPromotions =
      '${Constants.promotion}/user-discounts'; // Store voucher save
  static const String getCartPromotionsOfProduct =
      '${Constants.promotion}/cart-promotions-of-product'; // Show list promotions product in product detail
  static const String buyToReceivePresent =
      '${Constants.promotion}/item-promotions-of-product'; // Show/hide text "Buy to receive present" in product detail

  static const String addProductItemFavorite =
      '${Constants.customer}/favourite-product'; // Add current product item to favorite list
  static const String deleteProductItemFavorite =
      '${Constants.customer}/favourite-product'; // Delete current product item to favorite list
  static const String getListProductItemFavorite =
      '${Constants.customer}/favourite-product/getall'; // Get list of product item favorite
  static const String createProductItemViewed =
      '${Constants.customer}/viewed-product'; // Create a product viewed
  static const String getListProductItemViewed =
      '${Constants.customer}/viewed-product/search'; // Get list of product viewed

  static const String cartOder =
      '${Constants.customOrder}/create'; // Search order show order detail
  static const String searchOrderByNumber =
      '${Constants.customOrder}/search-by-number'; // Search order by orderId
  static const String searchOrderSendOtp =
      '${Constants.customOrder}/send-otp'; // Search order send OTP
  static const String searchOrderVerifyOtp =
      '${Constants.customOrder}/verify-otp'; // Search order verify OTP
  static const String searchOrderByPhone =
      '${Constants.customOrder}/search-by-phone'; // Search order by phone number
  static const String searchOrderDetail =
      Constants.customOrder; // Search order show order detail

  static const String getListFavouriteShop =
      '${Constants.customer}/favourite-store/search'; // Get list of favourite shop
  static const String addToListShopFavourite =
      '${Constants.customer}/favourite-store'; // Add shop you're favourite
  static const String deleteShopFavourite =
      '${Constants.customer}/favourite-store'; // Delete shop you're not favourite

  static const String addProductReview =
      '${Constants.productReview}/review'; // Add product rating/review
  static const String getListProductHasReview =
      '${Constants.productReview}/reviews'; // Get product has review/rating
  static const String getCustomerOrderHistories =
      '${Constants.customOrder}/histories'; // Get customer order histories

  //Base URL API
  static const baseUrl = "";
}
