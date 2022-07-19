import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/domain/request/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

enum LoginState { loading, initial }

class LoginController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  LoginController({required this.apiRepository, required this.localRepository});

  final usernameTextController = TextEditingController();
  final passwordTextControlller = TextEditingController();
  Rx<LoginState> loginState = LoginState.initial.obs;

  Future<bool> login() async {
    final username = usernameTextController.text;
    final password = passwordTextControlller.text;
    try {
      loginState(LoginState.loading);
      final loginResponse = await apiRepository
          .login(LoginRequest(username: username, password: password));
      localRepository.setToken(loginResponse.token);
      localRepository.saveUser(loginResponse.user);
      return true;
    } on AuthException catch (_) {
      loginState(LoginState.initial);
      return false;
    }
  }
}
