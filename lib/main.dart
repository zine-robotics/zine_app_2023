import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/app_providers.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/dashboard/profile.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/explore/achievements.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';
import 'package:zineapp2023/screens/onboarding/reset_password/email_screen.dart';
import 'package:zineapp2023/screens/onboarding/reset_password/reset_password_screen.dart';
import 'package:firebase_core/firebase_core.dart';

final Language _language = Language();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
        language: _language,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.blue,
          ),
          home: LandingScreen(),
        ));
  }
}
//