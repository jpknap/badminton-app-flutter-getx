import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Player extends StatelessWidget {
  final Rival rival;
  const Player({Key? key, required this.rival}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                Text("${rival.name} ${rival.lastname}",
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 4,
                ),
                Text("Victorias : ${rival.victories}"),
                const SizedBox(
                  height: 2,
                ),
                Text("Derrotas : ${rival.losses}"),
              ],
            )),
            DeliveryButton(
              onTap: () {
                final controller = Get.find<HomeController>();
                controller.setSelectUserRival(rival);
                controller.setIndex(2);
              },
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: DeliveryColors.white,
                  fontSize: 15,
                  wordSpacing: 2,
                  letterSpacing: 1.2),
              text: "Desafiar",
            ),
          ],
        ),
      ),
    );
  }
}
