import 'package:app_burger/domain/model/product.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartScreen extends GetWidget<HomeController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.car.value.isNotEmpty) {
        return _FullCart();
      } else {
        return _EmpyCart();
      }
    });
  }
}

class _EmpyCart extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          size: 150,
          Icons.my_library_add_outlined,
          color: Theme.of(context).textTheme.titleLarge!.color,
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Cart empy, please add elements.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(DeliveryColors.purple),
          ),
          onPressed: () {
            controller.navigateToProduct();
          },
          child: const Text('Go to elments'),
        ),
      ],
    );
  }
}

class _FullCart extends GetWidget<HomeController> {
  const _FullCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Product> myProducts = controller.car.value;
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                child: ListView.builder(
                    itemCount: myProducts.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      Product product = myProducts[index];
                      return _ItemProductCart(
                        product: product,
                        function: () {
                          controller.removeElementCar(product.id);
                        },
                      );
                    })),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub-total"),
                                  Text("\$ " +
                                      controller.getCarPrice().toString()),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery"),
                                  Text("free"),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$ " + controller.getCarPrice().toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          )),
                          DeliveryButton(
                            onTap: () {},
                            text: "Buy items",
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: DeliveryColors.white),
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ItemProductCart extends StatelessWidget {
  final Product product;
  final Function function;
  const _ItemProductCart(
      {Key? key, required this.product, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = product.name;
    final String description = product.description;
    final int sale = product.price;
    final int id = product.id;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(children: [
        Card(
          elevation: 8,
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                    Text(description),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            color: DeliveryColors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5.0),
                              child: Text(
                                "5",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: DeliveryColors.dark,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    Text("\$ $sale",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).iconTheme.color)),
                  ],
                )),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              this.function();
            },
            child: CircleAvatar(
              backgroundColor: DeliveryColors.redDanger,
              child: Icon(Icons.delete_outline_outlined),
            ),
          ),
        ),
      ]),
    );
  }
}
