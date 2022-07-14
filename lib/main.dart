import 'package:app_burger/presentation/main_binding.dart';
import 'package:app_burger/presentation/routes/delivery_routes.dart';
import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: true ? ThemeApp.darkTheme : ThemeApp.lightTheme,
      initialRoute: DeliveryRoutes.splash,
      getPages: DeliveryPages.pages,
      initialBinding: MainBindings(),
    );
  }
}
