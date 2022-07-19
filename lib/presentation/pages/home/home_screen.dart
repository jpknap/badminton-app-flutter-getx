import 'package:app_burger/presentation/pages/home/favourites/favourites_screen.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/pages/home/products/products_screen.dart';
import 'package:app_burger/presentation/pages/home/profile/profile_screen.dart';
import 'package:app_burger/presentation/pages/home/rivals/rivals_screen.dart';
import 'package:app_burger/presentation/pages/home/shops/shops_screen.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'cart/cart_screen.dart';
import 'create_match/create_match_screen.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Obx(() {
                return IndexedStack(
                    index: controller.indexHome.value,
                    children: [
                      RivalsScreen(),
                      MatchsPendingScreen(),
                      CreateMatchScreen(),
                      MatchHistoryScreen(),
                      ProfileScreen(),
                    ]);
              })),
              Obx(() {
                return _DeliveryNavigationBar(
                    index: controller.indexHome.value,
                    onIndexSelected: (index) => {controller.setIndex(index)});
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  final index;
  final ValueChanged<int> onIndexSelected;
  const _DeliveryNavigationBar(
      {Key? key, required this.index, required this.onIndexSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 1,
                )
              ],
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 0 ? DeliveryColors.gree : null,
                    onPressed: () => onIndexSelected(0),
                    icon: Icon(Icons.home_outlined)),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 1 ? DeliveryColors.gree : null,
                    onPressed: () => onIndexSelected(1),
                    icon: Icon(Icons.store_outlined)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: DeliveryColors.purple,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        color: index == 2
                            ? DeliveryColors.gree
                            : DeliveryColors.white,
                        onPressed: () => onIndexSelected(2),
                        icon: Icon(Icons.shopping_basket_outlined)),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 3 ? DeliveryColors.gree : null,
                    onPressed: () => onIndexSelected(3),
                    icon: Icon(Icons.favorite_border)),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 4 ? DeliveryColors.gree : null,
                    onPressed: () => onIndexSelected(4),
                    icon: Icon(Icons.person_outline)),
              ),
            ],
          ),
        ));
  }
}