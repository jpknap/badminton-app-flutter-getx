import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/presentation/pages/home/profile/profile_controller.dart';
import 'package:app_burger/presentation/pages/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(
        apiRepository: Get.find<ApiRepositoryInterface>(),
        localRepository: Get.find<LocalRepositoryInterface>()));
  }
}
