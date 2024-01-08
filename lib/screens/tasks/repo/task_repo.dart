import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import '../../../models/tasks.dart';

class TaskRepo {
  final UserProv userProv;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserModel userMod = UserModel();

  TaskRepo({required this.userProv});

  dynamic getUserModel(uid) async {
    var user = await _firebaseFirestore.collection('users').doc(uid).get();
    UserModel docData2 = UserModel.store(user);
    //print("user name is:${docData2.name}");
    print("getUserModel is called");
    return docData2;
  }

  dynamic getTasks(uid) async {

    var query = await _firebaseFirestore
        .collection("userTasks")
        .where("users", arrayContains: _firebaseFirestore.doc("/users/${uid}"));
    var data = await query.get();
    final docData = data.docs.map((doc) => UserTask.store(doc));
    //print("userTask.store displaying-->${docData.toList()}");
    print("getTasks is finished");
    return docData.toList();
  }

  dynamic getDocRef(ref) async {
    var doc = await _firebaseFirestore.doc(ref).get();
    Tasks docData = Tasks.store(doc);
    //print("\n\nhello:  ${docData.title}\n");
    return docData;
  }

  dynamic getDescTasks() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('userTasks')
        .doc('CozbjZuMu3UU8kl4fQxj')
        .get();
    final data = documentSnapshot.data()!;
    final arrayData = data['checkpoints'] as List<dynamic>;
    return arrayData;
  }

  dynamic addUserModel(uid) async {
    var users = await _firebaseFirestore.collection('users').doc(uid).get();
    userMod = UserModel.store(users);
    return userMod;
  }

  dynamic addCheckpoints(message) async {
    final uid = userProv.currUser.uid.toString();
    addUserModel(uid);

    //print("user info:\n user name:${userMod.name}\n user id:${userMod.uid}");

    var query = await _firebaseFirestore
        .collection("userTasks")
        .where("users", arrayContains: _firebaseFirestore.doc("/users/${uid}"));
    var snapshot = await query.get();
    final docRefId = snapshot.docs.first.reference.id;

    //print("docRefId is:$docRefId");

    Map<String, dynamic> checkpointData = {
      "message": message,
      "timeDate": DateTime.now(),
      "user": userMod.name.toString(),
    };
    final checkList = await FirebaseFirestore.instance
        .collection("userTasks")
        .doc(docRefId.toString())
        .update({
      "checkpoints": FieldValue.arrayUnion([checkpointData])
    });
    print("checkpoints data are added successfully");
  }

  dynamic addLinks(heading, link) async {
    final uid = userProv.currUser.uid.toString();
   // print("user uid :$uid");
    await addUserModel(uid);
    Map<String, dynamic> linkData = {
      "heading": heading,
      "timeDate": DateTime.now(),
      "user": userMod.name.toString(),
      "link": link,
    };
    //print("users uid is :${userMod.uid}");
    var query = await _firebaseFirestore.collection("userTasks").where("users",
        arrayContains:
            _firebaseFirestore.doc("/users/${userMod.uid.toString()}"));
    var snapshot = await query.get();
    final docRefId = snapshot.docs.first.reference.id;

    //print("docRefId is:$docRefId");
    final linkList = await FirebaseFirestore.instance
        .collection("userTasks")
        .doc(docRefId.toString())
        .update({
      "links": FieldValue.arrayUnion([linkData])
    });
    print("links added sucessfully");
  }
}
