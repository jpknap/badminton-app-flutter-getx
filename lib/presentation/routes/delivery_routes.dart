import 'package:app_burger/presentation/pages/home/create_match/select_user_scree.dart';
import 'package:app_burger/presentation/pages/home/home_bindings.dart';
import 'package:app_burger/presentation/pages/home/home_screen.dart';
import 'package:app_burger/presentation/pages/home/profile/profile_binding.dart';
import 'package:app_burger/presentation/pages/home/shops/result_match_screen.dart';
import 'package:app_burger/presentation/pages/login/login_binding.dart';
import 'package:app_burger/presentation/pages/login/login_screen.dart';
import 'package:app_burger/presentation/pages/splash/splash_binding.dart';
import 'package:app_burger/presentation/pages/splash/splash_screen.dart';
import 'package:get/route_manager.dart';

class DeliveryRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String selectUser = '/select-user';
  static const String resultMatch = '/result-match';
}

class DeliveryPages {
  static final pages = [
    GetPage(
        name: DeliveryRoutes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: DeliveryRoutes.login,
        page: () => LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: DeliveryRoutes.home,
        page: () => const HomeScreen(),
        bindings: [
          HomeBindings(),
          ProfileBindings(),
        ]),
    GetPage(
        name: DeliveryRoutes.selectUser,
        page: () => const SelectPickerUser(),
        bindings: [
          HomeBindings(),
        ]),
    GetPage(
        name: DeliveryRoutes.resultMatch, page: () => const ResultMatchScreen())
  ];
}
