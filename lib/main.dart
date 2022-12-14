import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_chart/core_binding.dart';
import 'package:test_chart/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:test_chart/services/storage/storage_service.dart';
import 'package:test_chart/shared/i18n/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = Get.find<StorageService>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (cxt, _) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Thị trường điện'.toUpperCase(),
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white),
              locale: storage.languageCode.isNotEmpty
                  ? Locale(storage.languageCode, storage.countryCode)
                  : const Locale('vi', 'VN'),
              fallbackLocale: const Locale('vi', 'VN'),
              translations: AppTranslations(),
              defaultTransition: Transition.native,
              getPages: AppPages.getPages,
              unknownRoute: AppPages.unknownRoute,
              initialRoute: AppPages.initial,
              initialBinding: CoreBinding(),
            ));
  }
}
