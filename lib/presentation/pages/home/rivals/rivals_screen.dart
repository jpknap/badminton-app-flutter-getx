import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RivalsScreen extends GetWidget<HomeController> {
  const RivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Center(
                child: Text(
              "Jugadores",
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
                    "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Obx(() {
                    List<Rival> rivals = controller.rivals.value;
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.60,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                        itemCount: rivals.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, index) {
                          return _ItemProduct(
                            rival: rivals[index],
                          );
                        });
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
  final Rival rival;
  const _ItemProduct({Key? key, required this.rival}) : super(key: key);

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
                SizedBox(
                  height: 4,
                ),
                Text("Victorias : ${rival.victories}"),
                SizedBox(
                  height: 2,
                ),
                Text("Derrotas : ${rival.losses}"),
              ],
            )),
            DeliveryButton(
              onTap: () {
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
