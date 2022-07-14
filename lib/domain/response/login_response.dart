import 'package:app_burger/domain/model/user.dart';

class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});
}
