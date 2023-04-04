import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/retry.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zineapp2023/api.dart';
import '../../../models/tasks.dart';

class TaskRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  dynamic getEvents() async {
    // print('get events called');
    var querySnapshot =
        await FirebaseFirestore.instance.collection("tasks").get();
    final _docData = querySnapshot.docs.map((doc) => Tasks.store(doc));
    return _docData.toList();
  }

  void postEvent(data) async {
    //asks newTask = Tasks.fromJson(data);
    await FirebaseFirestore.instance
        .collection("events")
        .add(data)
        .then((value) => {print(value)})
        .onError((error, stackTrace) => {print(error)});
  }
}
