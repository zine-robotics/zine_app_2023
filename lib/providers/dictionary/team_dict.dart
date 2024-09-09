/* This is the model for the Team Members 
TeamScreenDict returns a List Of Team Members, of every year.
*/

class TeamScreenDict {
  List<List<Team>>? team;

  TeamScreenDict({this.team});

  factory TeamScreenDict.fromJson(List<dynamic> json) {
    var tea = <List<Team>>[];
    var temp = <Team>[];
    for (var year in json) {
      for (var i in year) {
        temp.add(Team.fromJson(i));
      }
      tea.add(temp);
      temp = [];
    }
    return TeamScreenDict(team: tea);
  }
}

class Team {
  String? name;
  String? image;
  String? email;
  String? linkedIn;
  String? bio;
  String? branch;

  Team({
    this.name = "",
    this.image = "",
    this.email = "",
    this.linkedIn = "",
    this.bio = "",
    this.branch = ""
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json["name"],
      image: json["image"],
      email: json["email"],
      linkedIn: json["linkedin"] ?? 'zine.co.in',
      bio: json["bio"] ??
          "India, officially the Republic of India, is a country in South Asia. It is the seventh-largest country by area; the most populous country as of June 2023; and from the time of its independence in 1947, the world's most populous democracy",
      branch: json["branch"]  ?? 'Electronics and Communication'
    );
  }
}
