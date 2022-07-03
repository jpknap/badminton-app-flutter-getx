import 'package:app_burger/presentation/home/favourites/favourites_screen.dart';
import 'package:app_burger/presentation/home/products/products_screen.dart';
import 'package:app_burger/presentation/home/profile/profile_screen.dart';
import 'package:app_burger/presentation/home/shops/shops_screen.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';

import 'cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: IndexedStack(
                index: currentIndex,
                children: [
                  ProductsScreen(),
                  ShopScreen(),
                  CartScreen(
                    goToProducts: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  FavouritesScreen(),
                  ProfileScreen(),
                ],
              )),
              _DeliveryNavigationBar(
                  index: currentIndex,
                  onIndexSelected: (index) => {
                        setState((() => {currentIndex = index}))
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
                    color: index == 0 ? DeliveryColors().gree : null,
                    onPressed: () => onIndexSelected(0),
                    icon: Icon(Icons.home_outlined)),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 1 ? DeliveryColors().gree : null,
                    onPressed: () => onIndexSelected(1),
                    icon: Icon(Icons.store_outlined)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: DeliveryColors().purple,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        color: index == 2
                            ? DeliveryColors().gree
                            : DeliveryColors().white,
                        onPressed: () => onIndexSelected(2),
                        icon: Icon(Icons.shopping_basket_outlined)),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 3 ? DeliveryColors().gree : null,
                    onPressed: () => onIndexSelected(3),
                    icon: Icon(Icons.favorite_border)),
              ),
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: IconButton(
                    color: index == 4 ? DeliveryColors().gree : null,
                    onPressed: () => onIndexSelected(4),
                    icon: Icon(Icons.person_outline)),
              ),
            ],
          ),
        ));
  }
}
