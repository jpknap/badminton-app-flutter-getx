import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefToken = 'TOKEN';
const _prefUsername = 'USERNAME';
const _prefName = 'NAME';
const _prefImage = 'IMAGE';
const _prefDarkMode = 'DARKMODE';

class LocalResponsitoryImp implements LocalRepositoryInterface {
  late SharedPreferences _sharedPreferences;
  LocalResponsitoryImp() {
    setSharedPreferences();
  }

  Future<void> setSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clearAllData() async {
    _sharedPreferences.clear();
  }

  @override
  Future<String> getToken() async {
    await setSharedPreferences();

    final String token = await _sharedPreferences.getString(_prefToken) ?? '';
    return token;
  }

  @override
  Future<void> setToken(String token) async {
    await setSharedPreferences();

    await _sharedPreferences.setString(_prefToken, token);
  }

  @override
  Future<User> getUser() async {
    await setSharedPreferences();

    final String name = _sharedPreferences.getString(_prefName) ?? '';
    final String username = _sharedPreferences.getString(_prefUsername) ?? '';
    final String image = _sharedPreferences.getString(_prefImage) ?? '';
    User user = User(name: name, username: username, image: image);
    return user;
  }

  @override
  Future<void> saveUser(User user) async {
    await setSharedPreferences();

    await _sharedPreferences.setString(_prefName, user.name);
    await _sharedPreferences.setString(_prefUsername, user.username);
    await _sharedPreferences.setString(_prefImage, user.image);
  }

  @override
  Future<void> saveDarkMode(bool darkmode) async {
    await setSharedPreferences();
    await _sharedPreferences.setBool(_prefDarkMode, darkmode);
  }

  @override
  Future<bool> isDarkMode() async {
    await setSharedPreferences();

    bool? isDarkMode = await _sharedPreferences.getBool(_prefDarkMode);
    return isDarkMode ?? false;
  }
}
