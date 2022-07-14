import 'package:app_burger/presentation/home/home_screen.dart';
import 'package:app_burger/presentation/login/login_binding.dart';
import 'package:app_burger/presentation/login/login_screen.dart';
import 'package:app_burger/presentation/splash/splash_binding.dart';
import 'package:app_burger/presentation/splash/splash_screen.dart';
import 'package:get/route_manager.dart';

class DeliveryRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
}

class DeliveryPages {
  static final pages = [
    GetPage(
        name: DeliveryRoutes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: DeliveryRoutes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(name: DeliveryRoutes.home, page: () => const HomeScreen()),
  ];
}
