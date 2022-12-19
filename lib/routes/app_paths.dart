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

  //system
  static const systemPage = _Paths.system;

  //account
  static const accountPage = _Paths.account;

  //Page drawer
  static const tonnagePage = _Paths.tonnage;
  static const outputPage = _Paths.output;
}

abstract class _Paths {
  static const login = '/login';
  static const register = '/register';

  static const home = '/home';

  static const system = '/system';

  static const account = '/account';

  //Page Drawer
  static const tonnage = '/tonnage';
  static const output = '/output';
}
