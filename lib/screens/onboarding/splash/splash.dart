import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/onboarding/splash/viewModel/splashVm.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashVM>(builder: (context, splashVm, _) {
      void checkLogged() {
        splashVm.isLogged(context);
      }

      return Container(
        child: ElevatedButton(
          onPressed: checkLogged,
          child: Text('Splash TimeOut'),
        ),
      );
    });
  }
}
