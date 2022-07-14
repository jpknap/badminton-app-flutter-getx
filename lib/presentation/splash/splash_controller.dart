import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  SplashController(
      {required this.apiRepository, required this.localRepository});

  @override
  void onReady() {
    validateSession();
    super.onReady();
  }

  void validateSession() async {
    final token = await localRepository.getToken();
    if (token.isEmpty) {
      Get.offNamed(DeliveryRoutes.login);
    } else {
      final User user = await apiRepository.getUserFromToken(token);
      localRepository.saveUser(user);
      Get.offNamed(DeliveryRoutes.home);
    }
  }
}
