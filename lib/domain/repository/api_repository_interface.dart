import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/request/login_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
import 'package:app_burger/domain/response/login_response.dart';

import '../request/create_duel_request.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> logout(String token);
  Future<List<Rival>> getRivals();
  Future<List<BadmintonMatch>> getPendingMatch(String token);
  Future<List<BadmintonMatch>> getHistoryMatch(String token);
  Future<void> createMatch(CreateDuelRequest createDuelRequest);
  Future<void> saveResultMatch(SaveResultMatchRequest saveResultMatchRequest);
}
