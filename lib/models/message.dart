import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  String? group;
  String? from;
  Timestamp? timeStamp;

  MessageModel({
    this.message,
    this.group,
    this.from,
    this.timeStamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    group = json['group'];
    from = json['from'];
    timeStamp = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['group'] = group;
    data['from'] = from;
    data['timeStamp'] = timeStamp;
    return data;
  }

  MessageModel.store(snapshot)
      : from = snapshot.data()['from'],
        group = snapshot.data()['group'],
        timeStamp = snapshot.data()['timeStamp'],
        message = snapshot.data()['message'];
}
