class GetAchivement {
  List<Achivement>? achivement;

  GetAchivement({this.achivement});

  GetAchivement.fromJson(Map<String, dynamic> json) {
    if (json['achivement'] != null) {
      achivement = <Achivement>[];
      json['achivement'].forEach((v) {
        achivement!.add(new Achivement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.achivement != null) {
      data['achivement'] = this.achivement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Achivement {
  String? title;
  String? description;
  String? date;

  Achivement({this.title, this.description, this.date});

  Achivement.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    return data;
  }
}
