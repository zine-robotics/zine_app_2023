import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';
import 'package:zineapp2023/screens/onboarding/view_models/auth_vm.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepo>(
          create: (_) => AuthRepo(),
        ),
        ChangeNotifierProvider(create: (_) => AuthViewModel())
      ],
      child: child,
    );
  }
}
