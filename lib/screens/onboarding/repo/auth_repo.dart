import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../models/user.dart';

class AuthRepo {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserModel? _userFromFirebase({required auth.User? user, String? name}) {
    if (user == null) {
      return null;
    }
    return UserModel(user.uid, user.email,name);
  }

  // Stream<User?>? get user {
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(user: credential.user);
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String name,
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(user: credential.user,name: name);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
