import 'user.dart';

class BadmintonMatch {
  final int id;
  final User userChallenger;
  final User userChallenging;
  final DateTime createdAt;
  final DateTime? finishedAt;
  final int? userChanllengerPoints;
  final int? userChanllengingPoints;

  const BadmintonMatch({
    required this.userChallenger,
    required this.id,
    required this.userChallenging,
    required this.createdAt,
    this.finishedAt,
    this.userChanllengerPoints,
    this.userChanllengingPoints,
  });
}
