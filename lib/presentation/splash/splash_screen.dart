import 'package:app_burger/presentation/login/login_screen.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientBackground)),
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: DeliveryColors().white,
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
          'Burger App',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
