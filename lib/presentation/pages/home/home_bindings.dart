import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        apiRepository: Get.find<ApiRepositoryInterface>(),
        localRepository: Get.find<LocalRepositoryInterface>()));
  }
}
