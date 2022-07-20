import 'package:app_burger/domain/model/product.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/domain/repository/api_repository_interface.dart';
import 'package:app_burger/domain/repository/local_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepository;
  final LocalRepositoryInterface localRepository;

  HomeController({required this.apiRepository, required this.localRepository});

  RxInt indexHome = 0.obs;
  Rx<List<Product>> car = Rx<List<Product>>([]);
  Rx<Rival?> rivalCreateForm = Rx<Rival?>(null);
  final challendPoints = TextEditingController();

  @override
  void onReady() {
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
}
