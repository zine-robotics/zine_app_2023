import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '/common/data_store.dart';
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

  Future<UserModel?> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );

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
        dp: user['dp'],
        type: user['type'],
        registered: user['registered']);

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

    // TODO : Uncomment before release
    // credential.user!.sendEmailVerification();

    return UserModel(
      uid: credential.user!.uid,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    store.delete(key: 'uid');
    store.delete(key: 'loggedIn');
  }
}
