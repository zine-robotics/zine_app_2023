import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  String? title;
  String? description;
  String? type;
  Timestamp? dueDate;
  Timestamp? createdDate;
  List<dynamic>? tags;
  String? link;
  String? submissionLink;

  Tasks(
      {this.title,
      this.description,
      this.type,
      this.dueDate,
      this.submissionLink,
      this.createdDate,
      this.tags,
      this.link});

  Tasks.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tags = json['tags'];
    dueDate = json['dueDate'];
    createdDate = json['createdDate'];
    type = json['type'];
    link = json['link'];
    submissionLink = json['submissionLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['tags'] = tags;
    data['dueDate'] = dueDate;
    data['createdDate'] = createdDate;
    data['type'] = type;
    data['link'] = link;

    return data;
  }

  Tasks.store(snapshot)
      : tags = snapshot.data()['tags'],
        description = snapshot.data()['description'],
        dueDate = snapshot.data()['dueDate'],
        createdDate = snapshot.data()['createdDate'],
        title = snapshot.data()['title'],
        type = snapshot.data()['type'],
        link = snapshot.data()['link'],
        submissionLink = snapshot.data()['submissionLink'];
}
