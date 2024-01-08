import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zineapp2023/models/tasks.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';

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

    if (!credential.user!.emailVerified) {
      signOut();
      print("User Logged out");
      throw FirebaseAuthException(code: 'unverified-email');
    }

    return _userFromFirebase(user: credential.user);
  }

  Future<bool> isUserReg(String email) async {
    var user = await _firebaseFirestore
        .collection("registrations")
        .where("email", isEqualTo: email)
        .get();
    if (user.size == 1) return true;
    return false;
  }

  dynamic getRoomData(String groupID) {
    return _firebaseFirestore
        .collection('rooms')
    // Assuming there is only one group with the given name
        .doc(groupID)
        .get()
        .then((querySnapshot) {
          //print("querySnapshot.data() is:${querySnapshot.data()?['image']}");
      return querySnapshot.data();
    });

  }

  dynamic getRoomMap(dynamic listRoomIds) async {
    dynamic roomDetails = {"group": {}, "project": {}};
    for (var item in listRoomIds) {
      // print(item);
      dynamic temp = await getRoomData(item);
       //print(temp['type']);
       //print(temp['image']);

      roomDetails[temp['type']][item] = temp['name'];

    }

    return roomDetails;
  }


  Future<Tasks> getTemp(UserTask e) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await e.task!.get() as DocumentSnapshot<Map<String, dynamic>>;

    if (!snapshot.data()!.containsKey('link')) {
      snapshot.data()!['links'] = [];
      await e.task!.update({'link': []});
    }

    Tasks data = Tasks.store(snapshot);

    return data;
  }

  Future<List<UserTask>?> getTasks(uid) async {
    var query = await _firebaseFirestore
        .collection("userTasks")
        .where("users", arrayContains: _firebaseFirestore.doc("/users/${uid}"));
    var data = await query.get();
    final docData = data.docs.map((doc) => UserTask.store(doc));

    // print(docData.toList());

    print("uid of user from auth_repo:$uid");

    return docData.toList();
  }

  Future<UserModel?> getUserbyId(String uid) async {
    var user = await _firebaseFirestore.collection('users').doc(uid).get();
   // UserModel docData = UserModel.store(user);
    user.data()!.putIfAbsent("lastSeen", () => {});

    var map = await getRoomMap(user['roomids']);
    var tasks = await getTasks(uid);
    List<Future<void>> futures = [];
    for (var e in tasks!) {
      futures.add(getTemp(e).then((value) => e.template = value));
    }

    await Future.wait(futures);

    // print(tasks);

    UserModel userMod = UserModel(
        uid: user['uid'],
        email: user['email'],
        name: user['name'],
        dp: user['dp'],
        type: user['type'],
        registered: user['registered'],
        tasks: tasks,
        rooms: user['rooms'],
        roomIDs: user['roomids'],
        roomDetails: map,
        lastSeen: user.data()!['lastSeen'] != null ? user['lastSeen'] : {});

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

    credential.user!.sendEmailVerification();

    return UserModel(
      uid: credential.user!.uid,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    store.delete(key: 'uid');
    store.setString('loggedIn','true');
  }
}