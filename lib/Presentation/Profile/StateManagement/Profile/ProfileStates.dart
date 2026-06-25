import 'package:tasks_management_system/Domain/Models/profile_response.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  ProfileResponse response;
  ProfileSuccessState(this.response);
}

class ProfileErrorState extends ProfileStates {
  String error;
  ProfileErrorState(this.error);
}
