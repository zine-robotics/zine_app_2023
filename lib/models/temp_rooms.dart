class TempRooms {
  int? id;
  String? name;
  String? description;
  String? type;
  String? dpUrl;
  int? timestamp;

  TempRooms(
      {this.id,
        this.name,
        this.description,
        this.type,
        this.dpUrl,
        this.timestamp});

  TempRooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    dpUrl = json['dpUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['dpUrl'] = this.dpUrl;
    data['timestamp'] = this.timestamp;
    return data;
  }
}