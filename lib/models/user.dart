class User {
  String? email;
  String? uid;

  User(this.uid, this.email);

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['uid'] = this.uid;

    return data;
  }
}
