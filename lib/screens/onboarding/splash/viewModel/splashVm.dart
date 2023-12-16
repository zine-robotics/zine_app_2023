import "package:flutter/material.dart";

import '/common/data_store.dart';
import '/common/navigator.dart';
import '/common/routing.dart';
import '/models/user.dart';
import '/providers/user_info.dart';
import '/screens/onboarding/repo/auth_repo.dart';

class SplashVM extends ChangeNotifier {
  final DataStore store;
  final UserProv userProv;
  final AuthRepo authRepo;

  SplashVM(
      {required this.store, required this.userProv, required this.authRepo});

  String getData(String param) {
    String? data = store.getString(param);
    return data.toString();
  }

  Future<void> isLogged(BuildContext context) async {
    String? logged = store.getString('loggedIn');
    String? uid = store.getString('uid');

    if (logged != null && logged.toString() == 'true') {
      UserModel? currUser = await authRepo.getUserbyId(uid.toString());
      userProv.updateUserInfo(currUser as UserModel);
      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushReplacement(Routes.homeScreen());
    } else {
      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushReplacement(Routes.landingScreen());
    }
  }
}
