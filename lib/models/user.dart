class UserModel {
  String? email;
  String? uid;
  String? type;
  String? name;

  UserModel(this.uid, this.email,this.name);

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['name'] = this.name;

    return data;
  }
}
