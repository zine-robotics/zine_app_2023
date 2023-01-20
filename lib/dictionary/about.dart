class GetAbout {
  List<About>? about;

  GetAbout({this.about});

  GetAbout.fromJson(Map<String, dynamic> json) {
    if (json['about'] != null) {
      about = <About>[];
      json['about'].forEach((v) {
        about!.add(new About.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.about != null) {
      data['about'] = this.about!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class About {
  String? title;
  String? infoHead;
  String? infoBody;

  About({this.title, this.infoHead, this.infoBody});

  About.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    infoHead = json['infoHead'];
    infoBody = json['infoBody'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['infoHead'] = this.infoHead;
    data['infoBody'] = this.infoBody;
    return data;
  }
}
