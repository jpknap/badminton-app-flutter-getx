import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/rival.dart';
import 'package:app_burger/presentation/pages/home/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/model/user.dart';
import '../../../theme.dart';
import '../../../widgets/delivery_button/delivery_buttom.dart';

class RivalProfileScreen extends GetWidget<HomeController> {
  const RivalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Rival? rival = controller.rivalSelected;
    BadmintonMatch? maxPointsMatch = rival!.maxPointsMatch;
    BadmintonMatch? minPointsMatch = rival!.minPointsMatch;

    Widget rivalMaxMatch = maxPointsMatch is BadmintonMatch
        ? Container(
            child: Column(
              children: [
                Text(
                  "Maximus Match",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                RowMatchResume(match: maxPointsMatch)
              ],
            ),
          )
        : Container();
    Widget rivalMinMatch = minPointsMatch is BadmintonMatch
        ? Container(
            child: Column(
              children: [
                Text(
                  "Minimus Match",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                RowMatchResume(match: minPointsMatch)
              ],
            ),
          )
        : Container();

    if (rival is Rival) {
      return SafeArea(
        child: Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      padding: const EdgeInsets.only(right: 150),
                      child: Center(
                        child: Text("Profile",
                            style: Theme.of(context).textTheme.titleLarge!),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30,
                thickness: 2,
                indent: 160,
                endIndent: 160,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
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
              Center(
                child: Text(rival.name + " " + rival.lastname),
              ),
              rival.id != controller.userLogin?.id
                  ? DeliveryButton(
                      onTap: () {
                        final controller = Get.find<HomeController>();
                        controller.setIndex(2);
                        controller.setSelectUserRival(rival);
                        Get.back();
                      },
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: DeliveryColors.white,
                              fontSize: 15,
                              wordSpacing: 2,
                              letterSpacing: 1.2),
                      text: "Desafiar",
                    )
                  : SizedBox(),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Estadisticas",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Globales"),
                                    Row(
                                      children: [
                                        Text("V : " +
                                            rival.victories.toString()),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("D : " + rival.losses.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                rival.id != controller.userLogin?.id
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("VS"),
                                          Row(
                                            children: [
                                              Text("V : " +
                                                  rival.vsVictories.toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("D : " +
                                                  rival.vsLosses.toString()),
                                            ],
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                rivalMaxMatch,
                                rivalMinMatch,
                                const SizedBox(
                                  height: 20,
                                ),
                                rival.id != controller.userLogin?.id
                                    ? Text(
                                        "VS",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                rival.id != controller.userLogin?.id
                                    ? Container(
                                        height: 250,
                                        child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 1,
                                                          childAspectRatio: 4,
                                                          crossAxisSpacing: 4,
                                                          mainAxisSpacing: 4),
                                                  itemCount:
                                                      rival.vsMatchs.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    return RowMatchResume(
                                                      match:
                                                          rival.vsMatchs[index],
                                                    );
                                                  })
                                            ])))
                                    : SizedBox(),
                                rival.id != controller.userLogin?.id
                                    ? Text(
                                        "Ultimos Juegos",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 20,
                                ),
                                rival.id != controller.userLogin?.id
                                    ? Container(
                                        height: 300,
                                        child: SingleChildScrollView(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 1,
                                                          childAspectRatio: 4,
                                                          crossAxisSpacing: 4,
                                                          mainAxisSpacing: 4),
                                                  itemCount:
                                                      rival.lastsMatchs.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    return RowMatchResume(
                                                      match: rival
                                                          .lastsMatchs[index],
                                                    );
                                                  })
                                            ])))
                                    : SizedBox(),
                              ],
                            ))),
                  ),
                ),
              )
            ])),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class RowMatchResume extends StatelessWidget {
  final BadmintonMatch match;

  const RowMatchResume({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 8,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  "${match.userChallenging.name} vs ${match.userChallenger.name}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Creado ",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(timeago.format(match.createdAt, locale: 'es'))
                    ],
                  ),
                  Text(match.userChanllengingPoints.toString() +
                      "-" +
                      match.userChanllengerPoints.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
