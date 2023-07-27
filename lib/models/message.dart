import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  String? group;
  String? from;
  Timestamp? timeStamp;
  String? type;

  MessageModel({
    this.message,
    this.group,
    this.from,
    this.timeStamp,
    this.type,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    group = json['group'];
    from = json['from'];
    timeStamp = json['to'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['group'] = group;
    data['from'] = from;
    data['timeStamp'] = timeStamp;
    data['type'] = type;
    return data;
  }

  MessageModel.store(snapshot)
      : from = snapshot.data()['from'],
        group = snapshot.data()['group'],
        timeStamp = snapshot.data()['timeStamp'],
        type = snapshot.data()['type'],
        message = snapshot.data()['message'];
}
