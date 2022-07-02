import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback goToProducts;

  CartScreen({Key? key, required this.goToProducts}) : super(key: key);

  @override
  State<CartScreen> createState() =>
      _CartScreenState(goToProducts: goToProducts);
}

class _CartScreenState extends State<CartScreen> {
  final VoidCallback goToProducts;

  _CartScreenState({required this.goToProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        child: Center(
            child: Text(
          "Cart",
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
        child: _FullCaty(),
      )
    ]));
  }
}

class _ItemProduct extends StatelessWidget {
  final dynamic product;
  const _ItemProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = product['name'];
    final String description = product['description'];
    final int sale = product['sale'];

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
          ],
        ),
      ),
    );
  }
}

class _EmpyCart extends StatelessWidget {
  const _EmpyCart({Key? key, required this.goToProducts}) : super(key: key);
  final VoidCallback goToProducts;

  @override
  Widget build(BuildContext context) {
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
        Text(
          "Cart empy, please add elements.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(DeliveryColors().purple),
          ),
          onPressed: goToProducts,
          child: const Text('Go to elments'),
        ),
      ],
    );
  }
}

class _FullCaty extends StatelessWidget {
  _FullCaty({super.key});
  final List<Map> myProducts = List.generate(
      6,
      (index) => {
            "id": index,
            "name": "Caro uwu $index",
            "description": "Descripcion breve del producto",
            "sale": 2455 + (index * 250)
          }).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: DeliveryColors().pink,
            child: ListView.builder(
                itemCount: myProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _ItemProductCart(
                    product: myProducts[index],
                  );
                }),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(color: DeliveryColors().purple),
        ),
      ],
    );
  }
}

class _ItemProductCart extends StatelessWidget {
  final dynamic product;
  const _ItemProductCart({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = product['name'];
    final String description = product['description'];
    final int sale = product['sale'];

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
          ],
        ),
      ),
    );
  }
}
