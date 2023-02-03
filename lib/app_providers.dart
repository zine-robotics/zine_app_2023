import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/common/data_store.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/repo/chat_repo.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/home/view_models/home_view_model.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/login_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/register_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';
import 'package:zineapp2023/screens/onboarding/reset_password/view_model/pass_reset_view_model.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  final Language language;
  // final SharedPreferences prefs;
  final DataStore store;
  const AppProviders({
    required this.language,
    required this.store,
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepo>(
          create: (_) => AuthRepo(store: store),
        ),
        Provider<ChatRepo>(
          create: (_) => ChatRepo(),
        ),
        ChangeNotifierProvider(
            create: (_) => LoginAuthViewModel(
                myRepo: AuthRepo(store: store),
                userProvider: UserProv(dataStore: store))),
        ChangeNotifierProvider(
            create: (_) => RegisterAuthViewModel(
                store: store,
                myRepo: AuthRepo(store: store),
                userProvider: UserProv(dataStore: store))),
        ChangeNotifierProvider<DashboardVm>(
            create: (_) => DashboardVm(store: store)),
        ChangeNotifierProvider<HomeVm>(create: (_) => HomeVm()),
        ChangeNotifierProvider<Language>(create: (_) => language),
        ChangeNotifierProvider<PasswordResetVm>(
            create: (_) => PasswordResetVm(myRepo: AuthRepo(store: store)))
      ],
      child: child,
    );
  }
}
