import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/product.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/domain/request/create_duel_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  HomeController({required this.apiRepository, required this.localRepository});

  RxInt indexHome = 0.obs;
  Rx<List<Product>> car = Rx<List<Product>>([]);
  Rx<Rival?> rivalCreateForm = Rx<Rival?>(null);
  Rx<List<Rival>> rivals = Rx<List<Rival>>([]);
  Rx<List<BadmintonMatch>> matchHisotry = Rx<List<BadmintonMatch>>([]);
  Rx<List<BadmintonMatch>> matchPending = Rx<List<BadmintonMatch>>([]);
  Rival? rivalSelected = null;
  User? userLogin = null;
  RxBool loading = RxBool(false);

  BadmintonMatch? badmintonMatchSelected = null;
  final challendPoints = TextEditingController();
  final challingPoints = TextEditingController();

  @override
  void onReady() {
    setUserLogin();
    getMatchHistory();
    getMatchPending();
    getRivals();
    super.onReady();
    WidgetsBinding.instance.addObserver(this);
  }

  void setUserLogin() async {
    userLogin = await localRepository.getUser();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      reloadElements();
    }
  }

  void reloadElements() async {
    loading.value = true;
    getMatchHistory();
    getMatchPending();
    getRivals();
    await Future.delayed(Duration(milliseconds: 500));
    loading.value = false;
  }

  void addItem(Product product) {
    car.value.add(product);
    car.refresh();
  }

  List<Product> generateListCar() {
    return car.value;
  }

  void removeElementCar(int product_id) {
    bool removed = false;
    List<Product> productsCart = [];
    car.value.forEach((element) {
      if (element.id != product_id) {
        productsCart.add(element);
      } else {
        if (removed) {
          productsCart.add(element);
        }
        removed = true;
      }
    });
    car.value = productsCart;
    car.refresh();
  }

  int getCarPrice() {
    int total = 0;
    car.value.forEach((Product product) {
      total = product.price + total;
    });
    return total;
  }

  void navigateToProduct() {
    indexHome.value = 0;
  }

  void setIndex(int index) {
    indexHome.value = index;
  }

  void setSelectUserRival(Rival rival) {
    rivalCreateForm.value = rival;
  }

  void getRivals() async {
    String token = await localRepository.getToken();
    rivals.value = await apiRepository.getRivals(token);
    rivals.refresh();
  }

  void getMatchHistory() async {
    String token = await localRepository.getToken();
    matchHisotry.value = await apiRepository.getHistoryMatch(token);
    rivals.refresh();
  }

  void getMatchPending() async {
    String token = await localRepository.getToken();
    matchPending.value = await apiRepository.getPendingMatch(token);
    rivals.refresh();
  }

  void saveDuel() async {
    User user = await localRepository.getUser();
    Rival? rival = rivalCreateForm.value;
    if (rival is Rival && !loading.value) {
      loading.value = true;
      CreateDuelRequest createDuelRequest =
          CreateDuelRequest(user: user, rival: rival);
      await apiRepository.createMatch(createDuelRequest);
      getMatchPending();
      await Future.delayed(Duration(milliseconds: 300));
      loading.value = false;
      rivalCreateForm.value = null;
      indexHome.value = 1;
    } else {
      Get.snackbar("Error Formulario", "Debes seleccionar un rival.");

      NullThrownError();
    }
  }

  void saveResultMatch() async {
    BadmintonMatch? badmintonMatch = badmintonMatchSelected;
    if (badmintonMatch is BadmintonMatch && !loading.value) {
      loading.value = true;
      final int _challendPoints = int.parse(challendPoints.text);
      final int _challingPoints = int.parse(challingPoints.text);
      await apiRepository.saveResultMatch(SaveResultMatchRequest(
          badmintonMatch: BadmintonMatch(
              userChallenger: badmintonMatch.userChallenger,
              id: badmintonMatch.id,
              userChallenging: badmintonMatch.userChallenging,
              createdAt: badmintonMatch.createdAt,
              finishedAt: DateTime.now(),
              userChanllengerPoints: _challendPoints,
              userChanllengingPoints: _challingPoints)));
      await Future.delayed(Duration(milliseconds: 700));
      getMatchHistory();
      getMatchPending();
      getRivals();
      rivals.refresh();

      loading.value = false;
      challendPoints.text = "";
      challingPoints.text = "";
      Get.back();
    } else {
      Get.snackbar("Error Formulario", "Debes seleccionar un duelo.");
      badmintonMatch = null;
      NullThrownError();
    }
  }

  void loadRivalSelectedProfileScreen(Rival rival) {
    rivalSelected = rival;
    Get.toNamed(DeliveryRoutes.rivalProfile);
  }

  Future<User> getUserLogin() async {
    return await localRepository.getUser();
  }
}
