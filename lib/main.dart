import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/dashboard/profile.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';

final Language _language = Language();

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardVm>(create: (_)=>DashboardVm()),
        ChangeNotifierProvider<HomeVm>(create: (_)=>HomeVm()),
        ChangeNotifierProvider<Language>(create: (_)=>_language)
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