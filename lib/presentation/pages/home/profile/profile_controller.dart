import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  ProfileController(
      {required this.apiRepository, required this.localRepository});

  Rx<bool> isDarkMode = false.obs;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onReady() {
    validateTheme();
    getUser();
    super.onReady();
  }

  Future<void> validateTheme() async {
    final isDarkTheme = await localRepository.isDarkMode();
    isDarkMode.value = isDarkTheme;
  }

  Future<void> logout() async {
    await localRepository.clearAllData();
    Get.offNamed(DeliveryRoutes.splash);
  }

  Future<void> getUser() async {
    user.value = await localRepository.getUser();
  }

  void changeSwitch(bool checked) {
    isDarkMode.value = checked;
    Get.changeThemeMode(checked ? ThemeMode.dark : ThemeMode.light);
    localRepository.saveDarkMode(isDarkMode.value);
  }
}
