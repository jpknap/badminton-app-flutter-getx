import 'package:app_burger/domain/model/product.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

final List<Map> myProducts = List.generate(
    30,
    (index) => {
          "id": index,
          "name": "Caro uwu $index",
          "description": "Descripcion breve del producto",
          "sale": 2455 + (index * 250)
        }).toList();

class ProductsScreen extends GetWidget<HomeController> {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Center(
                child: Text(
              "Home",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )),
          ),
          Divider(
            height: 30,
            thickness: 2,
            indent: 160,
            endIndent: 160,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Products",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.60,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4),
                      itemCount: myProducts.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, index) {
                        return _ItemProduct(
                          product: myProducts[index],
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ItemProduct extends GetWidget<HomeController> {
  final dynamic product;
  const _ItemProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = product['name'];
    final int id = product['id'];
    final String description = product['description'];
    int sale = product['sale'] ?? 0;
    Product _product = Product(
        id: id, name: name, description: description, price: sale, image: "");
    return Card(
      elevation: 8,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 35,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(
                  height: 4,
                ),
                Text(description),
                SizedBox(
                  height: 2,
                ),
                Text("\$ $sale",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Theme.of(context).iconTheme.color)),
              ],
            )),
            DeliveryButton(
              onTap: () => {controller.addItem(_product)},
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: DeliveryColors.white,
                  fontSize: 15,
                  wordSpacing: 2,
                  letterSpacing: 1.2),
              text: "Buy",
            ),
          ],
        ),
      ),
    );
  }
}
