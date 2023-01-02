import 'package:get/get.dart';
import 'package:test_chart/routes/bindings/account/account_binding.dart';
import 'package:test_chart/routes/bindings/auth/login_binding.dart';
import 'package:test_chart/routes/bindings/auth/register_binding.dart';
import 'package:test_chart/routes/bindings/drawer/marginal_price_binding.dart';
import 'package:test_chart/routes/bindings/drawer/output_binding.dart';
import 'package:test_chart/routes/bindings/drawer/source_plan_binding.dart';
import 'package:test_chart/routes/bindings/drawer/tonnage_binding.dart';
import 'package:test_chart/routes/bindings/home/home_binding.dart';
import 'package:test_chart/routes/bindings/home/system_binding.dart';
import 'package:test_chart/views/authorized/pages/home_page.dart';
import 'package:test_chart/views/authorized/pages/system_page.dart';
import 'package:test_chart/views/authorized/screens/account_screen.dart';
import 'package:test_chart/views/authorized/screens/marginal_price_screen.dart';
import 'package:test_chart/views/authorized/screens/output_screen.dart';
import 'package:test_chart/views/authorized/screens/source_plan_screen.dart';
import 'package:test_chart/views/authorized/screens/tonnage_screen.dart';
import 'package:test_chart/views/not_found/not_found.dart';
import 'package:test_chart/views/unauthorized/login_screen.dart';
import 'package:test_chart/views/unauthorized/register_screen.dart';

part 'app_paths.dart';

class AppPages {
  AppPages._();

  static String initial = Routes.notFound;

  static final unknownRoute =
      GetPage(name: Routes.notFound, page: () => const NotFoundScreen());

  static final homePage = GetPage(
      name: Routes.homePage,
      transition: Transition.native,
      page: () => HomePage(),
      binding: HomeBinding());

  static final loginPage = GetPage(
      name: Routes.login,
      transition: Transition.native,
      page: () => const LoginScreen(),
      binding: LoginBinding());

  static final registerPage = GetPage(
      name: Routes.register,
      transition: Transition.native,
      page: () => const RegisterScreen(),
      binding: RegisterBinding());

  static final systemPage = GetPage(
      name: Routes.systemPage,
      transition: Transition.native,
      page: () => SystemPage(),
      binding: SystemBinding());

  static final accountPage = GetPage(
      name: Routes.accountPage,
      transition: Transition.native,
      page: () => AccountScreen(),
      binding: AccountBinding());

  static final tonnageScreen = GetPage(
      name: Routes.tonnageScreen,
      transition: Transition.native,
      page: () => TonnagePage(),
      binding: TonnageBinding());

  static final outputScreen = GetPage(
      name: Routes.outputScreen,
      transition: Transition.native,
      page: () => const OutputScreen(),
      binding: OutputBinding());

  static final marginalPriceScreen = GetPage(
      name: Routes.marginalPriceScreen,
      transition: Transition.native,
      page: () => const MarginalPriceScreen(),
      binding: MarginalPriceBinding());

  static final sourcePlanScreen = GetPage(
      name: Routes.sourcePlanScreen,
      transition: Transition.native,
      page: () => SourcePlanScreen(),
      binding: SourcePlanBinding());

  static final List<GetPage> getPages = [
    unknownRoute,
    homePage,
    loginPage,
    registerPage,
    systemPage,
    accountPage,

    //Page Drawer
    tonnageScreen,
    outputScreen,
    marginalPriceScreen,
    sourcePlanScreen
  ];
}
