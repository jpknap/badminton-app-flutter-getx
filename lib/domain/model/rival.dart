import 'badminton_match.dart';

class Rival {
  final int id;
  final String name;
  final String lastname;
  final int victories;
  final int losses;
  final int vsVictories;
  final int vsLosses;
  final String image;
  final List<BadmintonMatch> lastsMatchs;
  final List<BadmintonMatch> vsMatchs;
  final BadmintonMatch? maxWinMatch;
  final BadmintonMatch? maxPointsMatch;
  final BadmintonMatch? maxLoseMatch;
  final BadmintonMatch? minPointsMatch;

  const Rival({
    required this.name,
    required this.id,
    required this.lastname,
    required this.victories,
    required this.losses,
    this.vsLosses = 0,
    this.vsVictories = 0,
    required this.image,
    this.lastsMatchs = const [],
    this.vsMatchs = const [],
    this.maxWinMatch,
    this.maxPointsMatch,
    this.maxLoseMatch,
    this.minPointsMatch,
  });
}
