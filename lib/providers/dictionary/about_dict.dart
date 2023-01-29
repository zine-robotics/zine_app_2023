class AboutScreenDict {
  List<About>? about;

  AboutScreenDict({
    this.about,
  });

  factory AboutScreenDict.fromJson(List<dynamic> json) {
    var ab = <About>[];
    for (var v in json) {
      ab.add(About.fromJson(v));
    }
    return AboutScreenDict(
      about: ab
    );
  }
}

class About {
  String? title;
  String? infoHead;
  String? infoBody;

  About({
    this.title = "",
    this.infoHead = "",
    this.infoBody = "",
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
        title: json['title'],
        infoHead: json['infoHead'],
        infoBody: json['infoBody']);
  }
}
