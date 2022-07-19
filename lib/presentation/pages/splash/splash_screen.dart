import 'package:app_burger/presentation/pages/splash/splash_controller.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientBackground)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: DeliveryColors.white,
                radius: 50,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/732/732090.png'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Badminton App',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
