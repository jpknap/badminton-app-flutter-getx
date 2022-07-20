import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMatchScreen extends GetWidget<HomeController> {
  const CreateMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(
          child: Text(
        "Crear Duelo",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      )),
      Divider(
        height: 30,
        thickness: 2,
        indent: 160,
        endIndent: 160,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
      Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Rival:',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(DeliveryRoutes.selectUser);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .color!)),
                      height: 40,
                      child: Center(
                        child: (Obx(() {
                          Rival? rival = controller.rivalCreateForm.value;
                          if (rival is Rival) {
                            return Text(rival.name + " " + rival.lastname);
                          }
                          {
                            return Text("Selecciona rival");
                          }
                        })),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Tipo de Juego:',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .color!)),
                    height: 40,
                    child: Center(child: Text("Mejor de 1 Juego")),
                  ),
                ),
              ],
            ),
          )),
      Expanded(
          child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(DeliveryColors.purple),
            ),
            onPressed: () {
              controller.saveDuel();
            },
            child: const Text('Crear duelo'),
          ),
        ),
      ))
    ]));
  }
}
