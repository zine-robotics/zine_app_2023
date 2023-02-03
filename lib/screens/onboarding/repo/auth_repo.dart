import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zineapp2023/common/data_store.dart';
import 'package:zineapp2023/providers/user_info.dart';
import '../../../models/user.dart';

class AuthRepo {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late DataStore store;

  AuthRepo({required this.store});

  Future<void> sendResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserModel?> _userFromFirebase({required auth.User? user}) async {
    if (user == null) {
      return null;
    }
    UserModel? userMod = await getUserbyId(user.uid);

    return userMod;
  }

  // String? getUserFirebaseId() {
  //   return prefs.getString(FirestoreConstants.id);
  // }

  // Stream<User?>? get user {
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }

  Future<UserModel?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    // print(credential);
    // store.setString('uid', credential.user!.uid);
    // // store.setString('uid', credential.user!.name);
    // print('hello');
    // getUserbyId(credential.user!.uid);
    // print(await store.getString('uid'));

    //TODO - Uncomment before Release
    // if(!credential.user!.emailVerified){
    //   signOut();
    //   print("User Logged out");
    //   throw FirebaseAuthException(code: 'unverified-email');
    // }

    return _userFromFirebase(user: credential.user);
  }

  Future<UserModel?> getUserbyId(String uid) async {
    var user = await _firebaseFirestore.collection('users').doc(uid).get();

    UserModel userMod = UserModel(
        uid: user['uid'],
        email: user['email'],
        name: user['name'],
        dp: user['dp']);

    return userMod;
  }

  Future<UserModel?> createUserWithEmailAndPassword({
    String? name,
    String? email,
    String? password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );

    return _userFromFirebase(user: credential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    store.delete(key: 'uid');
    store.delete(key: 'loggedIn');
  }
}
