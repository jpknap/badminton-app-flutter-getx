import 'package:app_burger/data/datasource/api_repository_node_heroku_imp.dart';
import 'package:app_burger/data/datasource/api_repository_node_imp.dart';
import 'package:app_burger/data/datasource/local_repository_imp.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:get/instance_manager.dart';

import '../data/datasource/api_repository_imp.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalResponsitoryImp(),
        fenix: true);
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryNodeHerokuImp(),
        fenix: true);
  }
}
