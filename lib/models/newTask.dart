

class UserNewTask {

  String? name;
  String? id;
  String? description;

  UserNewTask(
      {this.name, this.id, this.description});

  UserNewTask.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['description'] = description;
    return data;
  }



  UserNewTask.store(snapshot)
      : name = snapshot.data()['name'],
        id = snapshot.data()['id'],
        description = snapshot.data()['description'];


}
