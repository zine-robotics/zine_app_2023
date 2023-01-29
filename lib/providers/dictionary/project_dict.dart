class ProjectScreen {
  List<Project>? projects;

  ProjectScreen({this.projects});

  factory ProjectScreen.fromJson(List<dynamic> json) {
    var proj = <Project>[];
    for (var v in json) {
      proj.add(Project.fromJson(v));
    }
    return ProjectScreen(projects: proj);
  }
}

class Project {
  String? name;
  String? description;

  Project({this.name, this.description});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
    );
  }
}
