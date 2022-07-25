import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/exception/other_exception.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/domain/request/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginState { loading, initial }

class LoginController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  LoginController({required this.apiRepository, required this.localRepository});

  final emailTextController = TextEditingController();
  final passwordTextControlller = TextEditingController();

  Rx<LoginState> loginState = LoginState.initial.obs;
  Rx<String?> errorEmail = Rx<String?>(null);
  Rx<String?> errorPassword = Rx<String?>(null);

  Future<bool> login() async {
    final email = emailTextController.text;
    final password = passwordTextControlller.text;
    errorEmail.value = null;
    errorPassword.value = null;

    if (!Validation.checkEmailFormat(email)) {
      errorEmail.value = "Debes ingresar un e-mail valido";
      return false;
    }
    if (!Validation.checkNoBlanck(password)) {
      errorPassword.value = "Debes ingresar password";
      return false;
    }

    try {
      loginState(LoginState.loading);
      final loginResponse = await apiRepository
          .login(LoginRequest(username: email, password: password));
      localRepository.setToken(loginResponse.token);
      localRepository.saveUser(loginResponse.user);
      return true;
    } on AuthException catch (_) {
      loginState(LoginState.initial);
      return false;
    } on OtherException catch (_) {
      loginState(LoginState.initial);
      return false;
    }
  }
}

class Validation {
  static bool checkEmailFormat(String email) {
    final RegExp regExEmail = RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');

    return regExEmail.hasMatch(email);
  }

  static bool checkNoBlanck(String text) {
    return text.isNotEmpty;
  }
}
