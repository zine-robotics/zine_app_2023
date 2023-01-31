import 'package:flutter/material.dart';
import 'package:zineapp2023/app_providers.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/navigator.dart';

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
          navigatorKey: NavigationService.navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.blue,
          ),
          home: const LandingScreen(),
        ));
  }
}
//