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

  // dynamic getUserModel(uid) async {
  //   var user = await _firebaseFirestore.collection('users').doc(uid).get();
  //   // UserModel docData2 = UserModel.store(user);
  //   //print("user name is:${docData2.name}");
  //   print("getUserModel is called");
  //   return docData2;
  // }

  dynamic getTasks(uid) async {
    var query = await _firebaseFirestore
        .collection("userTasks")
        .where("users", arrayContains: _firebaseFirestore.doc("/users/$uid"));
    var data = await query.get();

    final docData = data.docs.map((doc) => UserTask.store(doc));

    print("getTasks is finished");
    return docData.toList();
  }

  dynamic getDocRef(ref) async {
    var doc = await _firebaseFirestore.doc(ref).get();
    Tasks docData = Tasks.store(doc);
    return docData;
  }

  dynamic addCheckpoints(String message, String docRefId, int curr) async {
    Map<String, dynamic> checkpointData = {
      "message": message,
      "timeDate": Timestamp.now(),
      "user": userProv.getUserInfo.name.toString(),
    };
    //check if its working
    // userProv.getUserInfo.tasks?[curr].checkpoints?.add(checkpointData);
    await _firebaseFirestore
        .collection("userTasks")
        .doc(docRefId.toString())
        .update({
      "checkpoints": FieldValue.arrayUnion([checkpointData])
    });
  }

  dynamic addLinks(heading, link, String docRefId, int curr) async {
    Map<String, dynamic> linkData = {
      "heading": heading,
      "timeDate": Timestamp.now(),
      "user": userProv.getUserInfo.name.toString(),
      "link": link,
    };
    userProv.getUserInfo.tasks?[curr].links?.add(linkData);
    await _firebaseFirestore.collection("userTasks").doc(docRefId).update({
      "links": FieldValue.arrayUnion([linkData])
    });

    print("links added sucessfully");
  }
}
