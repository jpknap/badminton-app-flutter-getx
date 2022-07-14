import 'package:app_burger/domain/model/user.dart';

abstract class LocalRepositoryInterface {
  Future<String> getToken();
  Future<void> setToken(String token);
  Future<void> clearAllData();
  Future<void> saveUser(User user);
  Future<User> getUser();
  Future<void> saveDarkMode(bool darkmode);
  Future<bool> isDarkMode();
}
