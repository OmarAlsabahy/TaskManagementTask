import 'package:tasks_management_system/Domain/Models/login_response.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  LoginResponse response;

  LoginSuccessState(this.response);
}
class LoginErrorState extends LoginStates{
  String error;
  LoginErrorState(this.error);
}