import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/widgets/select_picker/select_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CreateMatchScreen extends GetWidget<HomeController> {
  const CreateMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        child: Center(
            child: Text(
          "Crear Duelo",
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
              child: ElevatedButton(
        child: Column(
          children: [
            Text("clickme"),
            (Obx(
              () {
                Rival? rival = controller.rivalCreateForm.value;
                if (rival is Rival) {
                  return Text(rival.id.toString() + " " + rival.name);
                } else {
                  return Text("sin asignar");
                }
                ;
              },
            ))
          ],
        ),
        onPressed: (() {
          Get.toNamed(DeliveryRoutes.selectUser);
        }),
      )))
    ]));
  }
}
