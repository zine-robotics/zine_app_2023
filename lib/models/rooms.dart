class Rooms {
  String? uid;
  String? name;
  List<dynamic> members = [];
  String? type;


  Rooms({
    this.uid,
    this.name,
    required this.members,
  });

  Rooms.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    members = json['members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['members'] = members;
    return data;
  }
  Rooms.store(snapshot)
      :
        name = snapshot.data()['name'],
        members = snapshot.data()['members'],
        type = snapshot.data()['type'];
}
