import 'package:app_burger/presentation/home/home_screen.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getHeader(context),
          getMiddle(context),
          getFooter(context),
        ],
      ),
    );
  }

  Widget getHeader(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          child: Stack(children: [
            Positioned(
                height: 240,
                bottom: 40,
                left: -50,
                right: -50,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: gradientBackground),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(200))),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  backgroundColor: DeliveryColors.white,
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/732/732090.png'),
                  ),
                )),
          ]),
        ));
  }

  Widget getMiddle(BuildContext context) {
    return Expanded(
        flex: 2,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Username',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person_outline)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Password',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline)),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getFooter(BuildContext context) {
    return SafeArea(
        child: DeliveryButton(
      text: "Login",
      textStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: DeliveryColors.white),
      padding: const EdgeInsets.all(8.0),
      onTap: () => {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()))
      },
    ));
  }
}
