import 'package:app_burger/domain/model/user.dart';

import '../model/rival.dart';

class CreateDuelRequest {
  final User user;
  final Rival rival;

  CreateDuelRequest({required this.user, required this.rival});
}
