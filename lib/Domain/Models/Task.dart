class Task {
  Task({
    required this.description,
    required this.id,
    required this.completed,
    required this.title,
    required this.priority,
  });

  String description;
  int? id=null;
  bool completed;
  String title;
  int priority;

  factory Task.fromJson(Map<dynamic, dynamic> json) => Task(
    description: json["description"],
    id: json["id"],
    completed: json["completed"] is int ? json["completed"] == 1 : json["completed"] ?? false,
    title: json["title"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "id": id,
    "completed": completed,
    "title": title,
    "priority": priority,
  };
}