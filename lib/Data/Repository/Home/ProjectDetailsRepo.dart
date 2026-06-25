import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_management_system/Data/Api/ApiHandler.dart';
import 'package:tasks_management_system/Data/Api/AppPaths.dart';
import 'package:tasks_management_system/Data/Database/AppDatabase.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IProjectDetailsRepo.dart';
import 'package:tasks_management_system/Domain/Models/Task.dart' as taskResponse;

class ProjectDetailsRepo extends IProjectDetailsRepo {
  ApiHandler _apiHandler;
  AppDatabase _database;
  ProjectDetailsRepo(this._apiHandler,this._database);

  @override
  Future<Either<ProjectsResponse, String>> getProjectDetails(int id) async {
    try {
      final result = await _apiHandler.get("${AppPaths.projects}/$id");
      final response = ProjectsResponse.fromJson(result.data);
      return Left(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _apiHandler.refreshToken();
        return await getProjectDetails(id);
      }else{
        final result = await _database.getTaskByProjectId(id);
        return Left(ProjectsResponse(
          id: id,
          name: "",
          description: "",
          tasks: result,
        ));
      }
    } catch (e) {
      final result = await _database.getTaskByProjectId(id);
      return Left(ProjectsResponse(
        id: id,
        name: "",
        description: "",
        tasks: result,
      ));
      }
  }

  @override
  Future<Either<void, String>> updateTask(taskResponse.Task task) async {
    try {
      final result = await _apiHandler.put("${AppPaths.tasks}/${task.id}", data: task.toJson());
      if(result.statusCode == 204){
        return Left(null);
      }else{
        return Right(result.toString());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _apiHandler.refreshToken();
        return await updateTask(task);
      }
      return Right(e.toString());
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<ProjectsResponse, String>> addTask(ProjectsResponse project) async {
    try {
      final Map<String, dynamic> data = {
        "name": project.name,
        "description": project.description,
        "tasks": project.tasks.map((t) => {
          "title": t.title,
          "description": t.description,
          "priority": t.priority,
          "completed": t.completed,
        }).toList(),
      };

      final result = await _apiHandler.put("${AppPaths.projects}/${project.id}", data: data);
      return Left(ProjectsResponse.fromJson(result.data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _apiHandler.refreshToken();
        return await addTask(project);
      }
      return Left(project);
    } catch (e) {
      return Left(project);
    }
  }
}
