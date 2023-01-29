class ProjectScreenDict {
  List<Project>? projects;

  ProjectScreenDict({this.projects});

  factory ProjectScreenDict.fromJson(List<dynamic> json) {
    var proj = <Project>[];
    for (var v in json) {
      proj.add(Project.fromJson(v));
    }
    return ProjectScreenDict(projects: proj);
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
