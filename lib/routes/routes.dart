import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/dashboard/dashboard.dart';
import 'package:zineapp2023/screens/home.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case 'dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
