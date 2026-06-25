import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IHomeRepo.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Home/HomeStates.dart';

class HomeCubit extends Cubit<HomeStates>{
  IHomeRepo _repo;
  HomeCubit(this._repo):super(HomeInitialState());
  getProjects()async{
    emit(HomeLoadingState());
    try{
      final result = await _repo.getProjects();
      result.fold((response) {
        emit(HomeSuccessState(response));
      }, (error) {
        emit(HomeErrorState(error));
      });
    }catch(e){
      emit(HomeErrorState(e.toString()));
    }
  }
}