import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../common/routing.dart';
import '../../../models/user.dart';
import '../repo/auth_repo.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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


  Future<void> postDetailsToFirestore(UserModel userModel) async {
    print('create user called');

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toJson());
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
        .createUserWithEmailAndPassword(data['name'],data['email'], data['password'])
        .then((value) {
      print("account called");
      print(data['name']);
      setLoading(false);
      print("account created");

      String? uid = value?.uid;
      print(value!.uid);
      UserModel userModel = UserModel(uid, data['email'], data['name']);
      postDetailsToFirestore(userModel);
      // postUser();
      // Utils.flushBarErrorMessage('SignUp Successfully', context);
      // Navigator.pushNamed(context, RoutesName.home);
      // if (kDebugMode) {
      //   print(value.toString());
      // }
    }).onError((error, stackTrace) {
      print(error);
      setLoading(false);
      print("account failed");
      // Utils.flushBarErrorMessage(error.toString(), context);
      // if (kDebugMode) {
      //   print(error.toString());
      // }
    });
  }
}
