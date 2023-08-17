import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zineapp2023/models/tasks.dart';

class UserTask {
  List<dynamic>? checkpoints;
  Map<String,dynamic>? links={};
  String? status;
  DocumentReference? task;
  List<dynamic>? users;
  Tasks? template;

  UserTask(
      {this.checkpoints, this.status, this.task, this.users, this.template});

  UserTask.fromJson(Map<String, dynamic> json) {
    checkpoints = json['checkpoints'];
    status = json['task'];
    task = json['task'];
    users = json['users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkpoints'] = checkpoints;
    data['task'] = task;
    data['users'] = users;
    return data;
  }



  UserTask.store(snapshot)
      : checkpoints = snapshot.data()['checkpoints'],
        status = snapshot.data()['status'],
        task = snapshot.data()['task'],
        users = snapshot.data()['users'],
        links=snapshot.data()['links'];
}
