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
  static const wattagePage = _Paths.wattage;

  //system
  static const systemPage = _Paths.system;

  //account
  static const accountPage = _Paths.account;

  //Page drawer
  static const tonnageScreen = _Paths.tonnage;
  static const outputScreen = _Paths.output;
  static const marginalPriceScreen = _Paths.marginalPrice;
  static const sourcePlanScreen = _Paths.sourcePlan;
  static const revenueScreen = _Paths.revenue;
  static const hydrologicalScreen = _Paths.hydrological;
}

abstract class _Paths {
  static const login = '/login';
  static const register = '/register';

  static const home = '/home';

  static const wattage = '/home/wattage';

  static const system = '/system';

  static const account = '/account';

  //Page Drawer
  static const tonnage = '/tonnage';
  static const output = '/output';
  static const marginalPrice = '/marginalPrice';
  static const sourcePlan = '/sourcePlan';
  static const revenue = '/revenue';
  static const hydrological = '/hydrological';
}
