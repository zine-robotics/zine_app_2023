import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../common/routing.dart';
import '../../../models/user.dart';
import '../repo/auth_repo.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepo();

  bool _loading = false;

  bool get loading => _loading;

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo
        .signInWithEmailAndPassword(data['email'], data['password'])
        .then((value) {
      setLoading(false);
      // final userPreference = Provider.of<UserViewModel>(context, listen: false);
      // userPreference.saveUser(UserModel(token: value['token'].toString()));
      print(value);
      // Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.of(context).pushAndRemoveUntil(Routes.homeScreen(), (Route<dynamic> route) => false);
      // if (kDebugMode) {
      //   print(value.toString());
      // }
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo
        .createUserWithEmailAndPassword(data['email'], data['password'])
        .then((value) {
      setLoading(false);
      print("account created");
      print(value);
      // Utils.flushBarErrorMessage('SignUp Successfully', context);
      // Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      print("account failed");
      // Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
