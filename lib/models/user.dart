import 'package:zineapp2023/models/userTask.dart';

class UserModel {
  String? email;
  String? uid;
  String? type = 'user';
  String? name;
  bool? registered = false;
  String? pushToken;
  List<UserTask>? tasks = [];
  List<dynamic>? rooms = [];
  List<dynamic>? roomIDs = [];
  dynamic roomDetails = {};
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
      this.rooms,
      this.roomIDs,
      this.roomDetails});

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
    roomIDs = json['roomids'];
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
    data['roomids'] = roomIDs;
    data['lastSeen'] = lastSeen;
    return data;
  }
  UserModel.store(snapshot)
      : email = snapshot.data()['email'],
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        type = snapshot.data()['type'],
        tasks = snapshot.data()['tasks'],
        dp = snapshot.data()['dp'],
        registered = snapshot.data()['registered'],
        pushToken = snapshot.data()['pushToken'],
        rooms = snapshot.data()['rooms'],
        roomIDs = snapshot.data()['roomIDs'],
        lastSeen = snapshot.data()['lastSeen'];




}
