import 'package:app_burger/presentation/pages/login/login_controller.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:app_burger/presentation/widgets/delivery_button/delivery_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<LoginController> {
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
                    child: Image.asset('assets/images/volante.png'),
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
                  'Badminton App',
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
                  'E-mail',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Obx(() {
                  return TextField(
                    controller: controller.emailTextController,
                    decoration: InputDecoration(
                        hintText: 'user@host.com',
                        errorText: controller.errorEmail.value,
                        prefixIcon: Icon(Icons.person_outline)),
                  );
                }),
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
                Obx(() {
                  return TextField(
                    controller: controller.passwordTextControlller,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        errorText: controller.errorPassword.value,
                        prefixIcon: Icon(Icons.lock_outline)),
                  );
                })
              ],
            ),
          ),
        ));
  }

  Widget getFooter(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: DeliveryButton(
        text: "Login",
        textStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: DeliveryColors.white),
        padding: const EdgeInsets.all(8.0),
        onTap: () => {login()},
      ),
    ));
  }
}
