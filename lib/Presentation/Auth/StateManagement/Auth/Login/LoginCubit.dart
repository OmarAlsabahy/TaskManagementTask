import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management_system/Domain/Repositories/Auth/ILoginRepo.dart';
import 'package:tasks_management_system/Presentation/Auth/StateManagement/Auth/Login/LoginStates.dart';

class LoginCubit extends Cubit<LoginStates>{
  ILoginRepo _repo;
  LoginCubit(this._repo):super(LoginInitialState());

  login(String userName , String password)async{
    emit(LoginLoadingState());
    try{
      final result = await _repo.login(userName, password);
      result.fold((response){
        emit(LoginSuccessState(response));
      }, (error){
        emit(LoginErrorState(error));
      });
    }catch(e){
      emit(LoginErrorState(e.toString()));
    }
  }
}