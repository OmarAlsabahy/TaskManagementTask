import 'package:dartz/dartz.dart';

import '../../Models/projects_response.dart';
import '../../Models/Task.dart' as taskResponse;


abstract class IProjectDetailsRepo{
  Future<Either<ProjectsResponse,String>>getProjectDetails(int id);
  Future<Either<void,String>>updateTask(taskResponse.Task task);
  Future<Either<ProjectsResponse,String>> addTask(ProjectsResponse project);
}