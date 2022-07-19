import 'package:app_burger/presentation/pages/login/login_controller.dart';
import 'package:get/instance_manager.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        apiRepository: Get.find(), localRepository: Get.find()));
  }
}
