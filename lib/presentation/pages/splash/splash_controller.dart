import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  SplashController(
      {required this.apiRepository, required this.localRepository});

  @override
  void onReady() {
    validateTheme();

    validateSession();
    super.onReady();
  }

  Future<void> validateTheme() async {
    final isDarkTheme = await localRepository.isDarkMode();
    Get.changeThemeMode(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> validateSession() async {
    final token = await localRepository.getToken();
    if (token.isEmpty) {
      Get.offNamed(DeliveryRoutes.login);
    } else {
      final User user = await apiRepository.getUserFromToken(token);
      localRepository.saveUser(user);
      Get.offNamed(DeliveryRoutes.home);
    }
  }
}
