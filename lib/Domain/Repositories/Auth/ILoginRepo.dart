import 'package:dartz/dartz.dart';
import 'package:tasks_management_system/Domain/Models/login_response.dart';

abstract class ILoginRepo{
  Future<Either<LoginResponse , String>> login(String userName , String password);
}