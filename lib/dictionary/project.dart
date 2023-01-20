class GetProject {
  List<Project>? project;

  GetProject({this.project});

  GetProject.fromJson(Map<String, dynamic> json) {
    if (json['project'] != null) {
      project = <Project>[];
      json['project'].forEach((v) {
        project!.add(new Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['project'] = this.project!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  String? name;
  String? description;

  Project({this.name, this.description});

  Project.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
