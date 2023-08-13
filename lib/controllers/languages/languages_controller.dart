import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import '/services/storage/storage_service.dart';
import '/shared/constants/keys.dart';

class LanguagesController extends GetxController {
  final storage = Get.find<StorageService>();
  final RxString locale = Get.locale.toString().obs;

  static String getFlag(String code) {
    switch (code) {
      case 'vi':
        return '🇻🇳';
      case 'en':
      default:
        return '🇺🇸';
    }
  }

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'en_description': 'English',
      'vi_description': 'Tiếng Anh',
    },
    'vi_VN': {
      'languageCode': 'vi',
      'countryCode': 'VN',
      'en_description': 'Vietnamese',
      'vi_description': 'Tiếng Việt',
    },
  };

  Future<void> updateLocale(String key) async {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    await Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    // Update storage
    storage
      // ignore: unawaited_futures
      ..write(Constants.languageCode, languageCode)
      // ignore: unawaited_futures
      ..write(Constants.countryCode, countryCode);
  }

  Future<void> setCurrentLocale(String locale) async {
    Phoenix.rebirth(Get.context!);
    await updateLocale(locale).whenComplete(() {
      Get
        ..reset()
        ..put(StorageService());
    });
  }
}
