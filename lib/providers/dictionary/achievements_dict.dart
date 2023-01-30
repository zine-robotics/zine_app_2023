class AchievementScreenDict {
  List<Achievement>? achievement;

  AchievementScreenDict({this.achievement});

  factory AchievementScreenDict.fromJson(List<dynamic> json) {
    var achieve = <Achievement>[];
    for (var v in json) {
      achieve.add(Achievement.fromJson(v));
    }
    return AchievementScreenDict(achievement: achieve);
  }
}

class Achievement {
  String? title;
  String? type;
  String? description;
  String? date;

  Achievement({
    this.title = "",
    this.type = "",
    this.description = "",
    this.date = "",
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
        title: json['title'],
        type: json["type"],
        description: json['description'],
        date: json['date']);
  }
}
