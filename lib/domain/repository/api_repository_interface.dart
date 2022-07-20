import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/request/login_request.dart';
import 'package:app_burger/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> logout(String token);
  Future<List<Rival>> getRivals();
  Future<List<BadmintonMatch>> getPendingMatch();
  Future<List<BadmintonMatch>> getHistoryMatch();
  Future<void> createMatch();
}
