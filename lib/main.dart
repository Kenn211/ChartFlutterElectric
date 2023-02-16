import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  runApp(Phoenix(child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final storage = Get.find<StorageService>();
  var languageCode = 'vi';
  var countryCode = 'VN';

  Future<void> initFunction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString(Constants.languageCode) ?? 'vi';
    countryCode = prefs.getString(Constants.countryCode) ?? 'VN';
    Get.find<LanguagesController>()
        .updateLocale(Locale(languageCode, countryCode).toString());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (cxt, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onInit: initFunction,
        enableLog: true,
        title: 'Thị trường điện'.toUpperCase(),
        theme: ThemeData(
            primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
        fallbackLocale: const Locale('vi', 'VN'),
        translations: AppTranslations(),
        defaultTransition: Transition.native,
        getPages: AppPages.getPages,
        unknownRoute: AppPages.unknownRoute,
        initialRoute: AppPages.initial,
        initialBinding: CoreBinding(),
      ),
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
    );
  }
}
