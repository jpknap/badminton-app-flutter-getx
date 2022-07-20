import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultMatchScreen extends GetWidget<HomeController> {
  const ResultMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color:
                                  Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 120),
                            child: Center(
                              child: Text("Resultado",
                                  style:
                                      Theme.of(context).textTheme.titleLarge!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nombre Apellido1"),
                                Text("Nombre Apellido 2")
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Flexible(
                                      child: TextField(
                                        controller: controller.challendPoints,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintStyle: TextStyle(),
                                          hintText: '?',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "V/S",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Container(
                                    width: 80,
                                    child: Flexible(
                                      child: TextField(
                                        controller: controller.challingPoints,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintStyle: TextStyle(),
                                          hintText: '?',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    DeliveryColors.purple),
                              ),
                              onPressed: () {
                                controller.saveResultMatch();
                              },
                              child: const Text('Guardar resultado'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(child: Obx(() {
            if (controller.loading.value) {
              return Container(
                color: DeliveryColors.grey.withAlpha(150),
                child: const Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox.shrink();
            }
          }))
        ],
      ),
    );
    ;
  }
}

class _ItemProduct extends StatelessWidget {
  final Rival rival;
  const _ItemProduct({Key? key, required this.rival}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${rival.name} ${rival.lastname}",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
