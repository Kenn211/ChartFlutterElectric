import 'package:get/get.dart';
import 'package:test_chart/views/authorized/pages/home_page.dart';
import 'package:test_chart/views/not_found/not_found.dart';
import 'package:test_chart/views/unauthorized/login_screen.dart';
import 'package:test_chart/views/unauthorized/register_screen.dart';

part 'app_paths.dart';

class AppPages {
  AppPages._();

  static String initial = Routes.notFound;

  static final unknownRoute = GetPage(
    name: Routes.notFound,
    page: () => const NotFoundScreen(),
  );

  static final homePage = GetPage(
    name: Routes.homePage,
    page: () => const HomePage(),
  );

  static final loginPage =
      GetPage(name: Routes.login, page: () => const LoginScreen());

  static final registerPage =
      GetPage(name: Routes.register, page: () => const RegisterScreen());

  static final List<GetPage> getPages = [unknownRoute, homePage, loginPage];
}
