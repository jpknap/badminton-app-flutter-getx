import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            color: DeliveryColors().purple,
          )),
          _DeliveryNavigationBar()
        ],
      ),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  const _DeliveryNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.home_outlined)),
              IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.store_outlined)),
              IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.shopping_basket_outlined)),
              IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border)),
              IconButton(
                  iconSize: 40,
                  onPressed: () {},
                  icon: Icon(Icons.person_outline)),
            ],
          ),
        ));
  }
}
