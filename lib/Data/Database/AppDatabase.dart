import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../Domain/Models/Task.dart';
import '../../Domain/Models/projects_response.dart';

class AppDatabase{
  late Database instance;
  AppDatabase(){
    _initDatabase();
  }

  void _initDatabase()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    instance = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE projects (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT
          )
        ''');

          await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            priority INTEGER,
            completed INTEGER, 
            projectId INTEGER,
            FOREIGN KEY (projectId) REFERENCES projects (id) ON DELETE CASCADE
          )
        ''');
        });
  }
  Future<int> insertProject(ProjectsResponse project) async {
    final db = await instance.database;
    int id = await db.insert('projects', {'name': project.name, 'description': project.description},
    conflictAlgorithm: ConflictAlgorithm.replace);
    for (var task in project.tasks) {
      await insertTask(task, id);
    }
    return id;
  }

  Future<int> insertTask(Task task, int projectId) async {
    final db = await instance.database;
    return await db.insert('tasks', {
      'title': task.title,
      'description': task.description,
      'priority': task.priority,
      'completed': task.completed ? 1 : 0,
      'projectId': projectId
    },conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<ProjectsResponse>> getAllProjects() async {
    final db = await instance.database;
    final projectMaps = await db.query('projects');
    List<ProjectsResponse> projects = [];

    for (var item in projectMaps) {
      final taskMaps = await db.query('tasks', where: 'projectId = ?', whereArgs: [item['id']]);
      projects.add(ProjectsResponse(
        id: item['id'] as int,
        name: item['name'] as String,
        description: item['description'] as String,
        tasks: taskMaps.map((t) => Task.fromJson(t)).toList(),
      ));
    }
    return projects;
  }
  Future<List<Task>> getTaskByProjectId(int id)async{
    final db = await instance.database;
    final taskMaps = await db.query('tasks', where: 'projectId = ?', whereArgs: [id]);
    return taskMaps.map((t) => Task.fromJson(t)).toList();
  }
}