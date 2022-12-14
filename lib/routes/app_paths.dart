part of 'app_routes.dart';

abstract class Routes {
  Routes._();

  // unauthorized
  static const login = _Paths.login;
  static const register = _Paths.register;

  // UnKnown
  static const notFound = '/not_found';

  //home
  static const homePage = _Paths.home;
}

abstract class _Paths {
  static const login = '/login';
  static const register = '/register';

  static const home = '/home';
}
