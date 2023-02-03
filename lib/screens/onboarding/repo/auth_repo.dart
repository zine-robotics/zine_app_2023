import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/user.dart';

class AuthRepo {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<void> sendResetEmail(String email)async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  UserModel? _userFromFirebase({
    required auth.User? user,
    String? name,
  }) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: name,
    );
  }

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
    print(credential.toString());

    //TODO - Uncomment before Release
    // if(!credential.user!.emailVerified){
    //   signOut();
    //   print("User Logged out");
    //   throw FirebaseAuthException(code: 'unverified-email');
    // }

    return _userFromFirebase(user: credential.user);
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

    //TODO - Uncomment before Release
    // credential.user!.sendEmailVerification();

    return _userFromFirebase(
      user: credential.user,
      name: name,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
