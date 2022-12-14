import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_chart/routes/app_routes.dart';
// import 'package:test_chart/services/storage/storage_service.dart';
import 'package:get/get.dart';
// import 'package:test_chart/shared/i18n/app_translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final storage = Get.find<StorageService>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Thị trường điện'.toUpperCase(),
        theme: ThemeData(
            primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
        // locale: storage.languageCode.isNotEmpty
        //     ? Locale(storage.languageCode, storage.countryCode)
        //     : const Locale('vi', 'VN'),
        // fallbackLocale: const Locale('en', 'EN'),
        // translations: AppTranslations(),
        getPages: AppPages.getPages,
        unknownRoute: AppPages.unknownRoute,
        initialRoute: AppPages.initial);
  }
}
