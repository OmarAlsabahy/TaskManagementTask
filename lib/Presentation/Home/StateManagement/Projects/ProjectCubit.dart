import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management_system/Domain/Models/Task.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IProjectDetailsRepo.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Projects/ProjectStates.dart';

class ProjectCubit extends Cubit<ProjectStates>{
  IProjectDetailsRepo _rep;
  ProjectCubit(this._rep):super(ProjectInitialState());
  getProjectDetails(int id)async{
    emit(ProjectLoadingState());
    try{
      final result = await _rep.getProjectDetails(id);
      result.fold((response) {
        emit(ProjectSuccessState(response));
      }, (error) {
        emit(ProjectErrorState(error));
      });
      }catch(e){
      emit(ProjectErrorState(e.toString()));
    }
  }
  updateTask(Task task)async{
    try{
     await _rep.updateTask(task);
    }catch(e){
      rethrow;
    }
  }
  addTask(ProjectsResponse project)async{
    emit(ProjectLoadingState());
    try{
      final result = await _rep.addTask(project);
      result.fold((response) {
        emit(ProjectSuccessState(response));
      }, (error) {
        emit(ProjectErrorState(error));
      });
    }catch(e){
      emit(ProjectErrorState(e.toString()));
    }
  }
}