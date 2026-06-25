import 'package:dartz/dartz.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';

abstract class IHomeRepo{
  Future<Either<List<ProjectsResponse>,String>> getProjects();
}