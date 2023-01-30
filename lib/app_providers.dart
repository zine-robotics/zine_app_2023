import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';
import 'package:zineapp2023/screens/onboarding/view_models/auth_vm.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  final Language language;
  const AppProviders({required this.language, Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepo>(
          create: (_) => AuthRepo(),
        ),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<DashboardVm>(create: (_) => DashboardVm()),
        ChangeNotifierProvider<HomeVm>(create: (_) => HomeVm()),
        ChangeNotifierProvider<Language>(create: (_) => language)
      ],
      child: child,
    );
  }
}
