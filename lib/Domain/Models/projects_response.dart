import 'dart:convert';

import 'Task.dart';

class ProjectsResponse {
    ProjectsResponse({
        required this.name,
        required this.description,
        required this.id,
        required this.tasks,
    });

    String name;
    String description;
    int id;
    List<Task> tasks;

    factory ProjectsResponse.fromJson(Map<dynamic, dynamic> json) => ProjectsResponse(
        name: json["name"],
        description: json["description"],
        id: json["id"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "id": id,
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
    };
}


