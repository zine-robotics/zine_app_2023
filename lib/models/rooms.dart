class Rooms {
  String? uid;
  String? name;
  List<dynamic>? members = [];
  String? type;
  String? image;



  Rooms({
    this.uid,
    this.name,
    required this.members,
     this.image
  });

  Rooms.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    members = json['members'];
    image=json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['members'] = members;
    data['image']=image;
    return data;
  }
  Rooms.store(snapshot)
      :
        name = snapshot.data()['name'],
        image=snapshot.data()['image'],
        members = snapshot.data()['members'],
        type = snapshot.data()['type'];
}
