import 'package:flutter/material.dart';
import '../theme/color.dart';

/// This is the default Loading Screen. Use this Screen if you want to add a loader
/// anywhere in the App.

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      body: Container(
        color: backgroundGrey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/loader.gif"),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Beep. . Boop. . .",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                    color: greyText),
              )
            ],
          ),
        ),
      ),
    );
  }
}
