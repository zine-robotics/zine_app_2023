import "package:flutter/material.dart";
import 'package:zineapp2023/common/data_store.dart';
import 'package:zineapp2023/common/navigator.dart';
import 'package:zineapp2023/common/routing.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';

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
      print(uid.toString());
      UserModel? currUser = await authRepo.getUserbyId(uid.toString());
      print(currUser);
      userProv.updateUserInfo(currUser as UserModel);
      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushAndRemoveUntil(
              Routes.homeScreen(), (Route<dynamic> route) => false);
    } else {
      await Navigator.of(NavigationService.navigatorKey.currentContext!,
              rootNavigator: true)
          .pushAndRemoveUntil(
              Routes.landingScreen(), (Route<dynamic> route) => false);
    }
  }

  // get password => _password;

}
