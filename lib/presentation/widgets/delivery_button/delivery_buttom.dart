import 'package:app_burger/presentation/theme.dart';
import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets padding;
  final TextStyle textStyle;

  const DeliveryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.padding = const EdgeInsets.all(0),
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: gradientBackground)),
            height: 45,
            child: Padding(
              padding: padding,
              child: Center(
                child: Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ));
  }
}
