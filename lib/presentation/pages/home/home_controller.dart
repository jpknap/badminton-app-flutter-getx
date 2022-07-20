import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/product.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:app_burger/domain/request/create_duel_request.dart';
import 'package:app_burger/domain/request/save_result_match_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  HomeController({required this.apiRepository, required this.localRepository});

  RxInt indexHome = 0.obs;
  Rx<List<Product>> car = Rx<List<Product>>([]);
  Rx<Rival?> rivalCreateForm = Rx<Rival?>(null);
  Rx<List<Rival>> rivals = Rx<List<Rival>>([]);
  Rx<List<BadmintonMatch>> matchHisotry = Rx<List<BadmintonMatch>>([]);
  Rx<List<BadmintonMatch>> matchPending = Rx<List<BadmintonMatch>>([]);
  RxBool loading = RxBool(false);

  BadmintonMatch? badmintonMatchSelected = null;
  final challendPoints = TextEditingController();
  final challingPoints = TextEditingController();

  @override
  void onReady() {
    getMatchHistory();
    getMatchPending();
    getRivals();
    super.onReady();
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
    rivals.value = await apiRepository.getRivals();
    rivals.refresh();
  }

  void getMatchHistory() async {
    matchHisotry.value = await apiRepository.getHistoryMatch();
    rivals.refresh();
  }

  void getMatchPending() async {
    matchPending.value = await apiRepository.getPendingMatch();
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
      loading.value = false;
      rivalCreateForm.value = null;
    } else {
      Get.snackbar("Error Formulario", "Debes seleccionar un rival.");

      NullThrownError();
    }
  }

  void saveResultMatch() async {
    BadmintonMatch? badmintonMatch = badmintonMatchSelected;
    if (badmintonMatch is BadmintonMatch && !loading.value) {
      loading.value = true;
      final int _challendPoints = int.parse(challingPoints.text);
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
      loading.value = false;
    } else {
      Get.snackbar("Error Formulario", "Debes seleccionar un duelo.");
      badmintonMatch = null;
      NullThrownError();
    }
  }
}
