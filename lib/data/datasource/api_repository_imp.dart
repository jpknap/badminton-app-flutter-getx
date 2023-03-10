import 'package:app_burger/domain/exception/auth_exception.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/request/create_duel_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
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
          id: 1,
          name: 'firstname lastname 1',
          username: 'username',
          image: 'src');
    } else if (_tokenUser2 == token) {
      return const User(
          id: 2,
          name: 'firstname lastname 2',
          username: 'username',
          image: 'src');
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    await Future.delayed(const Duration(seconds: 2));

    if (loginRequest.username == 'test@test.com' &&
        loginRequest.password == '123456789') {
      return LoginResponse(
          token: _tokenUser1,
          user: const User(
              id: 1,
              name: 'firstname lastname 1',
              username: 'username',
              image: 'https://picsum.photos/200/300?random=1"'));
    } else if (loginRequest.username == 'test2' &&
        loginRequest.password == '123456789') {
      return LoginResponse(
          token: _tokenUser1,
          user: const User(
              id: 2,
              name: 'firstname lastname 2',
              username: 'username',
              image: 'https://picsum.photos/200/300?random=1"'));
    }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    //print("remove token from server");
  }

  @override
  Future<void> createMatch(CreateDuelRequest createDuelRequest) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<List<BadmintonMatch>> getHistoryMatch(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    final List<BadmintonMatch> badmintonMatches = generadorBadmintonMatchs(
        finishedAt: DateTime.now(),
        userChanllengerPoints: 20,
        userChanllengingPoints: 22);
    return badmintonMatches;
  }

  @override
  Future<List<BadmintonMatch>> getPendingMatch(String token) async {
    await Future.delayed(const Duration(seconds: 2));
    final List<BadmintonMatch> badmintonMatches = generadorBadmintonMatchs();
    return badmintonMatches;
  }

  @override
  Future<List<Rival>> getRivals(String token) async {
    await Future.delayed(Duration(seconds: 2));
    List<BadmintonMatch> matchs = generadorBadmintonMatchs(
        finishedAt: DateTime.now(),
        userChanllengerPoints: 20,
        userChanllengingPoints: 22);
    final List<Rival> rivals = List.generate(
        13,
        (index) => Rival(
            id: index,
            name: "name " + index.toString(),
            lastname: "apellido " + index.toString(),
            victories: 0,
            losses: 0,
            image: '',
            maxPointsMatch: matchs.first,
            minPointsMatch: matchs.first,
            vsMatchs: matchs,
            lastsMatchs: matchs));
    return rivals;
  }

  @override
  Future<void> saveResultMatch(
      SaveResultMatchRequest saveResultMatchRequest) async {
    await Future.delayed(const Duration(seconds: 2));
    print("guardado resut");
  }

  List<BadmintonMatch> generadorBadmintonMatchs(
      {finishedAt, userChanllengerPoints, userChanllengingPoints}) {
    final List<BadmintonMatch> badmintonMatches = List.generate(
        13,
        (index) => BadmintonMatch(
            id: index,
            userChallenger: const User(
                id: 1, name: 'name', username: 'username', image: 'image'),
            userChallenging: const User(
                id: 2, name: 'name', username: 'username', image: 'image'),
            createdAt: DateTime.now(),
            finishedAt: finishedAt,
            userChanllengerPoints: userChanllengerPoints,
            userChanllengingPoints: userChanllengingPoints));
    return badmintonMatches;
  }
}
