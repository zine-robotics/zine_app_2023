import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/app_providers.dart';
import 'package:zineapp2023/common/data_store.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/chat/chat_room.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zineapp2023/screens/onboarding/login/login_form.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'common/navigator.dart';

final Language _language = Language();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // ignore: unused_local_variable
  DataStore store = DefaultStore(await SharedPreferences.getInstance());

  // print('User granted permission: ${settings.authorizationStatus}');
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  // final SharedPreferences prefs;
  final DataStore store;
  const MyApp({
    super.key,
    required this.store,

    // required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return AppProviders(
        language: _language,
        store: store,
        child: MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
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