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

}
