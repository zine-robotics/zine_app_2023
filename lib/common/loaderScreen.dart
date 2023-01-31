import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/loader.gif"),
              const SizedBox(height: 50.0,),
              const Text(
                "Beep. . Boop. . .",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                  color: greyText
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
