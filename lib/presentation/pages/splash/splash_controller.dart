import 'package:app_burger/domain/exception/other_exception.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/domain/exception/auth_exception.dart';

import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  SplashController(
      {required this.apiRepository, required this.localRepository});

  RxDouble turns = RxDouble(0);

  @override
  void onReady() {
    validateTheme();
    rotateInfinite();
    validateSession();
    super.onReady();
  }

  Future<void> rotateInfinite() async {
    await Future.delayed(const Duration(milliseconds: 30));
    turns.value = turns.value + 0.2;
    rotateInfinite();
  }

  Future<void> validateTheme() async {
    final isDarkTheme = await localRepository.isDarkMode();
    Get.changeThemeMode(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> validateSession() async {
    final token = await localRepository.getToken();
    await Future.delayed(const Duration(seconds: 1));
    if (token.isEmpty) {
      Get.offNamed(DeliveryRoutes.login);
    } else {
      try {
        final User user = await apiRepository.getUserFromToken(token);
        localRepository.saveUser(user);
        Get.offNamed(DeliveryRoutes.home);
      } on AuthException catch (_) {
        localRepository.clearAllData();
        Get.offNamed(DeliveryRoutes.login);
      } on OtherException catch (_) {
        localRepository.clearAllData();
        Get.offNamed(DeliveryRoutes.login);
      }
    }
  }
}
