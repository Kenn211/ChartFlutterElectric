import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_chart/core.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
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
