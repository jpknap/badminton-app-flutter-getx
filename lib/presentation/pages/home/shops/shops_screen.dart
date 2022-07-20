import 'package:app_burger/domain/model/badminton_match.dart';
import 'package:app_burger/domain/model/user.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

final List<BadmintonMatch> badmintonMatches = List.generate(
    13,
    (index) => BadmintonMatch(
        id: index,
        userChallenger:
            User(name: 'name', username: 'username', image: 'image'),
        userChallenging:
            User(name: 'name', username: 'username', image: 'image'),
        createdAt: DateTime.now(),
        finishedAt: null,
        userChanllengerPoints: 20,
        userChanllengingPoints: 22));

class MatchsPendingScreen extends StatelessWidget {
  const MatchsPendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        child: Center(
            child: Text(
          "Desafios",
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
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(15.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: badmintonMatches.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onLongPress: () {
                      Get.toNamed(DeliveryRoutes.resultMatch);
                    },
                    child: RowMatchResume(
                      match: badmintonMatches[index],
                    ),
                  );
                })
          ])))
    ]));
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                  "${match.userChallenger.name} vs ${match.userChallenging.name}"),
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
                  Text("? - ?")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
