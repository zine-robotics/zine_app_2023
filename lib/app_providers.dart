import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/repo/chat_repo.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/screens/explore/view_model/timeline_vm.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';

import './common/data_store.dart';
import './providers/dictionary.dart';
import './providers/user_info.dart';
import './screens/dashboard/view_models/dashboard_vm.dart';
import './screens/home/view_models/home_view_model.dart';
import './screens/onboarding/login/view_models/login_auth_vm.dart';
import './screens/onboarding/login/view_models/register_auth_vm.dart';
import './screens/onboarding/repo/auth_repo.dart';
import './screens/onboarding/reset_password/view_model/pass_reset_view_model.dart';
import './screens/onboarding/splash/viewModel/splashVm.dart';

/// This file is responsible for creating the Top-Level Providers of data and all
/// the View Models are instantiated here.
///
/// This is a MultiProvider which is wrapped around our main app.

class AppProviders extends StatelessWidget {
  final Widget child;
  final Language language;
  final DataStore store;
  final UserProv userProv;

  const AppProviders({
    required this.language,
    required this.store,
    required this.child,
    required this.userProv,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepo>(create: (_) => AuthRepo(store: store)),
        Provider<ChatRepo>(create: (_) => ChatRepo()),
        ChangeNotifierProvider(create: (_) => userProv),
        ChangeNotifierProvider(
            create: (_) => SplashVM(
                store: store,
                userProv: userProv,
                authRepo: AuthRepo(store: store))),
        ChangeNotifierProvider(
            create: (_) => LoginAuthViewModel(
                myRepo: AuthRepo(store: store), userProvider: userProv)),
        ChangeNotifierProvider(
            create: (_) => RegisterAuthViewModel(
                store: store,
                myRepo: AuthRepo(store: store),
                userProvider: UserProv(dataStore: store))),
        ChangeNotifierProvider<DashboardVm>(
            create: (_) => DashboardVm(store: store, userProv: userProv)),
        ChangeNotifierProvider<EventsVm>(create: (_) => EventsVm()),
        ChangeNotifierProvider<TaskVm>(create: (_) => TaskVm()),
        ChangeNotifierProvider<TimelineVm>(create: (_) => TimelineVm()),
        ChangeNotifierProvider<HomeVm>(create: (_) => HomeVm()),
        ChangeNotifierProvider<Language>(create: (_) => language),
        ChangeNotifierProvider<PasswordResetVm>(
            create: (_) => PasswordResetVm(myRepo: AuthRepo(store: store))),
        ChangeNotifierProvider<ChatRoomViewModel>(
            create: (_) => ChatRoomViewModel(userProv: userProv))
      ],
      child: child,
    );
  }
}
