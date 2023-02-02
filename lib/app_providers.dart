import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/login_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/register_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';

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
        ChangeNotifierProvider(create: (_) => LoginAuthViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterAuthViewModel()),
        ChangeNotifierProvider<DashboardVm>(create: (_) => DashboardVm()),
        ChangeNotifierProvider<HomeVm>(create: (_) => HomeVm()),
        ChangeNotifierProvider<Language>(create: (_) => language)
      ],
      child: child,
    );
  }
}
