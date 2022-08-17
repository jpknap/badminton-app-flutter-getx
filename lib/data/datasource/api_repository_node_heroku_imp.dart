import 'dart:convert';

import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/exception/other_exception.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/request/create_duel_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
import 'package:app_burger/domain/response/login_response.dart';
import 'package:app_burger/domain/request/login_request.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const HOST = 'https://warm-island-46858.herokuapp.com';
const LOGIN = '/login';
const LOGIN_TOKEN = '/login-token';
const SAVE_RESULT = '/match/result';

class ApiRepositoryNodeHerokuImp implements ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    try {
      Map<String, String> body = {'token': token};

      http.Response response = await postRequest("$HOST$LOGIN_TOKEN", "", body);
      if (response.statusCode == 200) {
        dynamic _user = jsonDecode(response.body);
        return User(
            id: _user['id'],
            image: '',
            name: _user['name'],
            username: _user['email']);
      }

      throw AuthException();
    } on Exception catch (_) {
      throw OtherException();
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      String username = loginRequest.username;
      String password = loginRequest.password;

      Map<String, String> body = {'email': username, 'password': password};

      http.Response response = await postRequest("$HOST$LOGIN", "", body);
      if (response.statusCode == 200) {
        dynamic user = jsonDecode(response.body);
        return LoginResponse(
            token: user['token'],
            user: User(
                id: user['id'],
                image: '',
                name: user['name'],
                username: user['email']));
      }

      throw AuthException();
    } on Exception catch (_) {
      throw OtherException();
    }
  }

  @override
  Future<void> logout(String token) async {
    print("remove token from server");
  }

  @override
  Future<List<Rival>> getRivals(String token) async {
    String response = await http.read(Uri.parse("$HOST/users?token=$token"));
    List<Rival> rivals = [];
    if (response.length > 10) {
      dynamic users = jsonDecode(response);
      for (dynamic _user in users) {
        rivals.add(Rival(
            name: _user['name'],
            id: _user['id'],
            lastname: '',
            victories: _user['victories'],
            losses: _user['losses'],
            vsVictories: _user['vsWin'],
            vsLosses: _user['vsLoss'],
            maxPointsMatch: getMatchJson(_user['matchMax']),
            minPointsMatch: getMatchJson(_user['matchMin']),
            vsMatchs: getMatchsJson(_user['matchVs']),
            lastsMatchs: getMatchsJson(_user['lastMatchs']),
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
      DateFormat dateFormat = DateFormat('d/MM/yyyy H:m');
      for (dynamic match in matchs) {
        badmintonMatches.add(BadmintonMatch(
            id: match['id'],
            userChallenger: User(
                id: match['userChallenged']['id'],
                name: match['userChallenged']['name'],
                username: match['userChallenged']['email'],
                image: 'image'),
            userChallenging: User(
                id: match['userChallenging']['id'],
                name: match['userChallenging']['name'],
                username: match['userChallenging']['email'],
                image: 'image'),
            createdAt: dateFormat.parse(match['created_at']),
            finishedAt: DateTime.now(),
            userChanllengerPoints: match['pointsChallenged'],
            userChanllengingPoints: match['pointsChallenging']));
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
      DateFormat dateFormat = DateFormat('d/MM/yyyy H:m');
      for (dynamic match in matchs) {
        badmintonMatches.add(BadmintonMatch(
            id: match['id'],
            userChallenger: User(
                id: match['userChallenged']['id'],
                name: match['userChallenged']['name'],
                username: match['userChallenged']['email'],
                image: 'image'),
            userChallenging: User(
                id: match['userChallenging']['id'],
                name: match['userChallenging']['name'],
                username: match['userChallenging']['email'],
                image: 'image'),
            createdAt: dateFormat.parse(match['created_at']),
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
        saveResultMatchRequest.badmintonMatch.userChanllengerPoints ?? 0;
    try {
      Map<String, dynamic> body = {
        'id': idMatch,
        'pointsChallenging': pointsChallenging,
        'pointsChallenged': pointsChallenged
      };

      http.Response response = await postRequest("$HOST$SAVE_RESULT", "", body);
      if (response.statusCode == 200) {}
    } on Exception catch (_) {
      throw OtherException();
    }
  }

  @override
  Future<void> createMatch(CreateDuelRequest createDuelRequest) async {
    int idUser = createDuelRequest.rival.id;
    int idSelf = createDuelRequest.user.id;

    String response = await http.read(Uri.parse(
        "$HOST/match/create?userChallenging=$idSelf&userChallenged=$idUser"));
    print("guardado");
  }

  Future<http.Response> postRequest(
      String url, String token, Map<String, dynamic> body) async {
    Map<String, String> headers = Map<String, String>();
    headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
    });
    Object jsonBody = jsonEncode(body);
    return await http.post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  List<BadmintonMatch> getMatchsJson(List<dynamic> matchs) {
    List<BadmintonMatch> badmintonMatches = [];

    matchs.forEach((item) {
      badmintonMatches.add(getMatchJson(item));
    });

    return badmintonMatches;
  }

  BadmintonMatch getMatchJson(Map<String, dynamic> match) {
    DateFormat dateFormat = DateFormat('d/MM/yyyy H:m');
    Map<String, dynamic> userChanllend = match['userChallenged'];
    Map<String, dynamic> userChallenging = match['userChallenging'];

    return BadmintonMatch(
        id: match['id'],
        userChallenger: User(
            id: userChanllend['id'],
            name: userChanllend['name'],
            username: userChanllend['email'],
            image: 'image'),
        userChallenging: User(
            id: userChallenging['id'],
            name: userChallenging['name'],
            username: userChallenging['email'],
            image: 'image'),
        createdAt: dateFormat.parse(match['created_at']),
        finishedAt: DateTime.now(),
        userChanllengerPoints: match['pointsChallenged'],
        userChanllengingPoints: match['pointsChallenging']);
  }
}
