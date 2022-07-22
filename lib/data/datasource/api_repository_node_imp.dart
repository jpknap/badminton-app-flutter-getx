import 'dart:convert';

import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/request/create_duel_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
import 'package:app_burger/domain/response/login_response.dart';
import 'package:app_burger/domain/request/login_request.dart';

import 'package:http/http.dart' as http;

const HOST = 'http://localhost:3000';

class ApiRepositoryNodeImpl implements ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    String response =
        await http.read(Uri.parse("$HOST/login-token?token=$token"));
    if (response.length > 10) {
      dynamic _user = jsonDecode(response);
      return User(
          id: int.parse(_user['id']),
          image: '',
          name: _user['name'],
          username: _user['email']);
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    String username = loginRequest.username;
    String password = loginRequest.password;

    String response = await http
        .read(Uri.parse("$HOST/login?email=$username&password=$password"));
    if (response.length > 10) {
      dynamic _user = jsonDecode(response);
      return LoginResponse(
          token: _user['token'],
          user: User(
              id: int.parse(_user['id']),
              image: '',
              name: _user['name'],
              username: _user['email']));
    }

    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print("remove token from server");
  }

  @override
  Future<List<Rival>> getRivals() async {
    String response = await http.read(Uri.parse("$HOST/users"));
    List<Rival> rivals = [];
    if (response.length > 10) {
      dynamic users = jsonDecode(response);
      for (dynamic _user in users) {
        rivals.add(Rival(
            name: _user['name'],
            id: int.parse(_user['id']),
            lastname: '',
            victories: int.parse(_user['victories']),
            losses: int.parse(_user['losses']),
            image: ''));
      }
    }
    return rivals;
  }

  @override
  Future<List<BadmintonMatch>> getHistoryMatch(String token) async {
    String response =
        await http.read(Uri.parse("$HOST/matchs/history?token=$token"));
    List<BadmintonMatch> badmintonMatches = [];
    if (response.length > 10) {
      dynamic matchs = jsonDecode(response);
      for (dynamic match in matchs) {
        badmintonMatches.add(BadmintonMatch(
            id: match['id'],
            userChallenger: const User(
                id: 1, name: 'name', username: 'username', image: 'image'),
            userChallenging: const User(
                id: 2, name: 'name', username: 'username', image: 'image'),
            createdAt: DateTime.now().add(Duration(days: -3)),
            finishedAt: DateTime.now(),
            userChanllengerPoints: int.parse(match['pointsChallenged']),
            userChanllengingPoints: int.parse(match['pointsChallenging'])));
      }
    }
    return badmintonMatches;
  }

  @override
  Future<List<BadmintonMatch>> getPendingMatch(String token) async {
    String response =
        await http.read(Uri.parse("$HOST/matchs/pending?token=$token"));
    List<BadmintonMatch> badmintonMatches = [];
    if (response.length > 10) {
      dynamic matchs = jsonDecode(response);
      for (dynamic match in matchs) {
        print(match);
        badmintonMatches.add(BadmintonMatch(
            id: match['id'],
            userChallenger: const User(
                id: 1, name: 'name', username: 'username', image: 'image'),
            userChallenging: const User(
                id: 2, name: 'name', username: 'username', image: 'image'),
            createdAt: DateTime.now().add(Duration(days: -3)),
            finishedAt: null,
            userChanllengerPoints: 0,
            userChanllengingPoints: 0));
      }
    }
    return badmintonMatches;
  }

  @override
  Future<void> saveResultMatch(
      SaveResultMatchRequest saveResultMatchRequest) async {
    int idMatch = saveResultMatchRequest.badmintonMatch.id;
    int pointsChallenging =
        saveResultMatchRequest.badmintonMatch.userChanllengingPoints ?? 0;
    int pointsChallenged =
        saveResultMatchRequest.badmintonMatch.userChanllengingPoints ?? 0;
    String response = await http.read(Uri.parse(
        "$HOST/match/result?id=$idMatch&pointsChallenging=$pointsChallenging&pointsChallenged=$pointsChallenged"));
  }

  @override
  Future<void> createMatch(CreateDuelRequest createDuelRequest) async {
    int idUser = createDuelRequest.rival.id;
    int idSelf = createDuelRequest.user.id;

    String response = await http.read(Uri.parse(
        "$HOST/match/create?userChallenging=$idSelf&userChallenged=$idUser"));
    print("guardado");
  }
}
