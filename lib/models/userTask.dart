import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zineapp2023/models/tasks.dart';

class UserTask {
  List<dynamic>? checkpoints;
  List<dynamic>? links = [];
  String? status;
  DocumentReference? task;
  List<dynamic>? users;
  Tasks? template;
  String? docId;

  UserTask(
      {this.checkpoints,
      this.status,
      this.task,
      this.users,
      this.template,
      this.links});

  UserTask.fromJson(Map<String, dynamic> json) {
    checkpoints = json['checkpoints'];
    status = json['status'];
    task = json['task'];
    users = json['users'];
    links = json['links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkpoints'] = checkpoints;
    data['task'] = task;
    data['users'] = users;
    data['links'] = links;
    return data;
  }

  UserTask.store(snapshot)
      : checkpoints = snapshot.data()['checkpoints'],
        status = snapshot.data()['status'],
        task = snapshot.data()['task'],
        users = snapshot.data()['users'],
        links = snapshot.data()['links'],
        docId = snapshot.id.toString();
}
