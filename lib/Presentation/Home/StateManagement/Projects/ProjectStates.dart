import 'package:tasks_management_system/Domain/Models/projects_response.dart';

abstract class ProjectStates{}
class ProjectInitialState extends ProjectStates{}
class ProjectLoadingState extends ProjectStates{}
class ProjectSuccessState extends ProjectStates{
  final ProjectsResponse project;
  ProjectSuccessState(this.project);
}
class ProjectErrorState extends ProjectStates{
  final String error;
  ProjectErrorState(this.error);
}