import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? uid;
  String? type = 'user';
  String? name;
  bool? registered = false;
  String? pushToken;
  List<dynamic>? tasks = [];
  List<dynamic>? rooms = [];
  dynamic lastSeen;
  int? dp;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.type,
      this.dp,
      this.tasks,
      this.registered,
      this.pushToken,
      this.lastSeen,
      this.rooms});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
    type = json['type'];
    tasks = json['tasks'];
    dp = json['dp'];
    registered = json['registered'];
    pushToken = json['pushToken'];
    rooms = json['rooms'];
    lastSeen = json['lastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['uid'] = uid;
    data['name'] = name;
    data['type'] = type;
    data['tasks'] = tasks;
    data['dp'] = dp;
    data['registered'] = registered;
    data['pushToken'] = pushToken;
    data['rooms'] = rooms;
    data['lastSeen'] = lastSeen;
    return data;
  }
}
