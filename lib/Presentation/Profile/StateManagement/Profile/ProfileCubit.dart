import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management_system/Domain/Repositories/Profile/IProfileRepo.dart';
import 'package:tasks_management_system/Presentation/Profile/StateManagement/Profile/ProfileStates.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  IProfileRepo _repo;
  ProfileCubit(this._repo) : super(ProfileInitialState());

  getProfile() async {
    emit(ProfileLoadingState());
    try {
      final result = await _repo.getProfile();
      result.fold((response) {
        emit(ProfileSuccessState(response));
      }, (error) {
        emit(ProfileErrorState(error));
      });
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
  logout() async{
    await _repo.logout();
  }
}
