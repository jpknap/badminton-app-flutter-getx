import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/match.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/response/login_response.dart';
import 'package:app_burger/domain/request/login_request.dart';

const _tokenUser1 = 'AAA111';
const _tokenUser2 = 'AAA222';

class ApiRepositoryImpl implements ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_tokenUser1 == token) {
      return const User(
          name: 'firstname lastname 1', username: 'username', image: 'src');
    } else if (_tokenUser2 == token) {
      return const User(
          name: 'firstname lastname 2', username: 'username', image: 'src');
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    await Future.delayed(const Duration(seconds: 2));

    if (loginRequest.username == 'test' &&
        loginRequest.password == '123456789') {
      return LoginResponse(
          token: _tokenUser1,
          user: const User(
              name: 'firstname lastname 1',
              username: 'username',
              image: 'https://picsum.photos/200/300?random=1"'));
    } else if (loginRequest.username == 'test2' &&
        loginRequest.password == '123456789') {
      return LoginResponse(
          token: _tokenUser1,
          user: const User(
              name: 'firstname lastname 2',
              username: 'username',
              image: 'https://picsum.photos/200/300?random=1"'));
    }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print("remove token from server");
  }

  @override
  Future<void> createMatch() {
    // TODO: implement createMatch
    throw UnimplementedError();
  }

  @override
  Future<List<BadmintonMatch>> getHistoryMatch() {
    // TODO: implement getHistoryMatch
    throw UnimplementedError();
  }

  @override
  Future<List<BadmintonMatch>> getPendingMatch() {
    // TODO: implement getPendingMatch
    throw UnimplementedError();
  }

  @override
  Future<List<Rival>> getRivals() {
    // TODO: implement getRivals
    throw UnimplementedError();
  }
}
