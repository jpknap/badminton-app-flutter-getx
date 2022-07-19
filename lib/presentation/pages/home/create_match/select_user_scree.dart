import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<Rival> rivals = List.generate(
    13,
    (index) => Rival(
        id: index,
        name: "name " + index.toString(),
        lastname: "apellido " + index.toString(),
        victories: 0,
        losses: 0,
        image: ''));

class SelectPickerUser extends GetWidget<HomeController> {
  const SelectPickerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Center(
                          child: Text("Lista de adversarios",
                              style: Theme.of(context).textTheme.titleLarge!),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(15.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 4,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4),
                            itemCount: rivals.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  controller.setSelectUserRival(rivals[index]);
                                  Get.back();
                                },
                                child: _ItemProduct(
                                  rival: rivals[index],
                                ),
                              );
                            })))
              ],
            ),
          ),
        ),
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
