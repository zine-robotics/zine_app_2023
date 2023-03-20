import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  String? name;
  String? description;
  List<String>? members;
  String? type;
  String? status;
  Timestamp? dueDate;

  Tasks(
      {this.name,
      this.description,
      this.type,
      this.dueDate,
      this.members,
      this.status});

  Tasks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    members = json['members'];
    dueDate = json['dueDate'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['members'] = members;
    data['time'] = dueDate;
    data['type'] = type;
    data['status'] = status;
    return data;
  }

  Tasks.store(snapshot)
      : members = snapshot.data()['members'],
        description = snapshot.data()['description'],
        dueDate = snapshot.data()['dueDate'],
        name = snapshot.data()['name'],
        type = snapshot.data()['type'],
        status = snapshot.data()['status'];
}
