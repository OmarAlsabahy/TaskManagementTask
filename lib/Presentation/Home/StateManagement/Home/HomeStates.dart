import 'package:tasks_management_system/Domain/Models/projects_response.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{
  final List<ProjectsResponse> projects;
  HomeSuccessState(this.projects);
}
class HomeErrorState extends HomeStates{
  final String error;
  HomeErrorState(this.error);
}