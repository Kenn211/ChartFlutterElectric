import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core.dart';
import 'firebase_options.dart';
import 'shared/helpers/function_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getToken();
  final messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ignore: unused_local_variable
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {}
  });

  if (kDebugMode) {
    FlutterError.onError = (details) async {
      FunctionHelper.showError(
        error: details.exception.toString(),
        stack: details.stack.toString(),
      );
    };
    runZonedGuarded(
      () => runApp(Phoenix(child: const App())),
      (error, stack) async {
        FunctionHelper.showError(
          error: error.toString(),
          stack: stack.toString(),
        );
      },
    );
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runZonedGuarded(
      () => runApp(Phoenix(child: const App())),
      (error, stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final storage = Get.find<StorageService>();
  String languageCode = 'vi';
  String countryCode = 'VN';

  Future<void> initFunction() async {
    final prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString(Constants.languageCode) ?? 'vi';
    countryCode = prefs.getString(Constants.countryCode) ?? 'VN';
    await Get.find<LanguagesController>()
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
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
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
