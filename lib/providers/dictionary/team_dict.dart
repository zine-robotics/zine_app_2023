class TeamScreen {
  List<List<Team>>? team;

  TeamScreen({this.team});

  factory TeamScreen.fromJson(List<dynamic> json) {
    var tea = <List<Team>>[];
    var temp = <Team>[];
    for (var year in json) {
      for (var i in year) {
        temp.add(Team.fromJson(i));
      }
      tea.add(temp);
      temp = [];
    }
    return TeamScreen(team: tea);
  }
}

class Team {
  String? name;
  String? image;
  String? email;

  Team({
    this.name = "",
    this.image = "",
    this.email = "",
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json["name"],
      image: json["image"],
      email: json["email"],
    );
  }
}
