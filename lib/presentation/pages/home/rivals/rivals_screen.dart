import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'player_widget.dart';

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
                          return Player(
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
