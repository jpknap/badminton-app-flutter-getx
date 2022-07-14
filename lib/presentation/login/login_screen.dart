import 'package:app_burger/presentation/home/home_screen.dart';
import 'package:app_burger/presentation/login/login_controller.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  void login() async {
    final bool result = await controller.login();
    if (result) {
      Get.offAllNamed(DeliveryRoutes.home);
    } else {
      Get.snackbar('Error Login', 'Usuario o contraseña invalidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          getHeader(context),
          getMiddle(context),
          getFooter(context),
        ]),
        Positioned.fill(child: Obx(() {
          if (controller.loginState.value == LoginState.loading) {
            return Container(
              color: DeliveryColors.grey.withAlpha(100),
              child: const Center(child: CircularProgressIndicator()),
            );
          } else {
            return const SizedBox.shrink();
          }
        }))
      ]),
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
                TextField(
                  controller: controller.usernameTextController,
                  decoration: const InputDecoration(
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
                TextField(
                  controller: controller.passwordTextControlller,
                  obscureText: true,
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
      onTap: () => {login()},
    ));
  }
}
