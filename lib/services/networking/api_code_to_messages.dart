import 'package:get/get_utils/src/extensions/internacionalization.dart';

String transferCodeToMessages(String? code) {
  switch (code) {
    case 'UsernameExist':
      return 'exist_username'.tr;
    case 'EmailExist':
      return 'exist_email'.tr;
    case 'PhoneExist':
      return 'exist_phone'.tr;
    case 'UserIdNotExist':
      return 'exist_not_user_id'.tr;
    case 'MemberIdNotExist':
      return 'exist_not_member_id'.tr;
    case 'RoleIdNotExist':
      return 'exist_not_role_id'.tr;
    case 'EmailNotExist':
      return 'exist_not_email'.tr;
    case 'PhoneNotExist':
      return 'exist_not_phone'.tr;
    case 'PhoneOrEmailNotExist':
      return 'exist_not_phone_or_email'.tr;
    case 'MemberNotExist':
      return 'exist_not_member'.tr;
    case 'CatalogNotExist':
      return 'exist_not_catalog'.tr;
    case 'StoreNotExist':
      return 'exist_not_store'.tr;
    case 'UsernameInvalid':
      return 'invalid_username'.tr;
    case 'EmailInvalid':
      return 'invalid_email'.tr;
    case 'PhoneInvalid':
      return 'invalid_phone'.tr;
    case 'OtpInvalid':
      return 'invalid_otp'.tr;
    case 'SignatureInvalid':
      return 'invalid_signature'.tr;
    case 'StoreNameInvalid':
      return 'invalid_store_name'.tr;
    case 'CodeInvalid':
      return 'invalid_code'.tr;
    case 'CodeExist':
      return 'exist_code'.tr;
    case 'PasswordInvalid':
      return 'invalid_password'.tr;
    case 'PasswordNotSame':
      return 'invalid_same_password'.tr;
    case 'PasswordNotCorrect':
      return 'invalid_password_correct'.tr;
    case 'Required':
      return 'required'.tr;
    case 'DefaultRoleNotConfigured':
      return 'default_role_not_configured'.tr;
    case 'UserInOtherRole':
      return 'user_in_other_role'.tr;
    case 'CreateError':
      return 'create_error'.tr;
    case 'UpdateError':
      return 'update_error'.tr;
    case 'Error':
      return 'error'.tr;
    case 'FavouriteProductExists':
      return 'favourite_product_exist'.tr;
    case 'xteam':
      return 'ship_xteam'.tr;
    case 'none':
      return 'ship_none'.tr;
    case 'AM':
      return 'ship_am'.tr;
    case 'PM':
      return 'ship_pm'.tr;
    case 'CartNoData':
      return 'cart_no_data'.tr;
    case 'NoCustomer':
      return 'no_customer'.tr;
    case 'Cart':
      return 'voucher_cart'.tr;
    case 'Shipping':
      return 'voucher_shipping'.tr;
    case 'Item':
      return 'voucher_item'.tr;
    case 'AddressGhtkNotSupport':
      return 'address_ghtk_not_support'.tr;
    case 'FeeGhtkEmpty':
      return 'fee_ghtk'.tr;
    case 'FeeGhtkError':
      return 'fee_ghtk'.tr;
    case 'PaymentMethodInvalid':
      return 'payment_method_invalid'.tr;
    case 'CartDeliveryDateInvalid':
      return 'cart_delivery_date_invalid'.tr;
    case 'ProductOrVariantNotFound':
      return 'product_variant_not_found'.tr;
    case 'NotEnoughStock':
      return 'not_enough_stock'.tr;
    case 'IsNotExistShippingMethod':
      return 'product_not_eligible_shipping'.tr;
    case 'NoGetFeeShip':
      return 'no_get_fee_ship'.tr;
    case 'NoShipingMethod':
      return 'no_shipping_method'.tr;
    case 'OrderNotFound':
      return 'order_not_found'.tr;
    case 'OrderInvalid':
      return 'order_invalid'.tr;
    case 'SaleLocationAddressInvalid':
      return 'sale_location_invalid'.tr;
    case 'SaleLocationInvalid':
      return 'sale_location_invalid'.tr;
    case 'SaleLocationNotFound':
      return 'sale_location_not_found'.tr;
    case 'invalid_grant':
      return 'invalid_user'.tr;
    case 'locked':
      return 'locked'.tr;
    case 'status_locked':
      return 'status_locked'.tr;
    case 'CartNoShipping':
      return 'cart_no_shipping'.tr;
    default:
      return '$code';
  }
}
