class Rooms {
  String? uid;
  String? name;
  List<dynamic> group = [];

  Rooms({
    this.uid,
    this.name,
    required this.group,
  });

  Rooms.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['uid'] = uid;
    data['group'] = group;
    return data;
  }
}
