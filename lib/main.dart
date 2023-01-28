import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zineapp2023/dictionary/about.dart';
import 'package:zineapp2023/screens/dashboard/dashboard.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/explore/about/about.dart';
import 'package:zineapp2023/screens/explore/team/team.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';
import 'package:zineapp2023/screens/explore/explore.dart';
import 'package:zineapp2023/screens/chat/chat_home.dart';
import 'package:zineapp2023/screens/onboarding/login_screen.dart';

import 'package:zineapp2023/screens/explore/project.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>DashboardVm()),
        ChangeNotifierProvider(create: (_)=>HomeVm())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
//