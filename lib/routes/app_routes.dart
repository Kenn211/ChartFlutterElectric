import 'package:get/get.dart';

import 'bindings/index.dart';
import '/views/app_views.dart';

part 'app_paths.dart';

class AppPages {
  AppPages._();

  static String initial = Routes.notFound;

  static final unknownRoute =
      GetPage(name: Routes.notFound, page: () => const NotFoundScreen());

  static final homePage = GetPage(
      name: Routes.homePage,
      transition: Transition.native,
      page: () => const HomePage(),
      binding: HomeBinding());

  static final loginPage = GetPage(
      name: Routes.login,
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
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
      page: () => const SystemPage(),
      binding: SystemBinding());

  static final accountPage = GetPage(
      name: Routes.accountPage,
      transition: Transition.native,
      page: () => const AccountScreen(),
      binding: AccountBinding());

  static final List<GetPage> getDrawerPages = [
    GetPage(
        name: Routes.tonnageScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const TonnagePage(),
        binding: TonnageBinding()),
    GetPage(
        name: Routes.outputScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const OutputScreen(),
        binding: OutputBinding()),
    GetPage(
        name: Routes.marginalPriceScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const MarginalPriceScreen(),
        binding: MarginalPriceBinding()),
    GetPage(
        name: Routes.sourcePlanScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const SourcePlanScreen(),
        binding: SourcePlanBinding()),
    GetPage(
        name: Routes.revenueScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const RevenueScreen(),
        binding: RevenueBinding()),
    GetPage(
        name: Routes.hydrologicalScreen,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 300),
        page: () => const HydrologicalScreen(),
        binding: HydrologicalBinding()),
  ];

  static final List<GetPage> getPages = [
    unknownRoute,
    homePage,
    loginPage,
    registerPage,
    systemPage,
    accountPage,

    //Page Drawer
    ...getDrawerPages,
  ];
}
