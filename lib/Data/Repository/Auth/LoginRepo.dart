import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_management_system/Data/Api/ApiHandler.dart';
import 'package:tasks_management_system/Data/Api/AppPaths.dart';
import 'package:tasks_management_system/Domain/Models/login_response.dart';
import 'package:tasks_management_system/Domain/Repositories/Auth/ILoginRepo.dart';

class LoginRepo extends ILoginRepo{
  ApiHandler apiHandler;
  LoginRepo(this.apiHandler);

  @override
  Future<Either<LoginResponse, String>> login(String userName, String password) async{
    try{
      final result = await apiHandler.post(AppPaths.login,data: {
        "username":userName,
        "password":password
      });
      final response = LoginResponse.fromJson(result.data);
      return Left(response);
    }on DioException catch(e){
      return Right(e.message??"Network error");
    }catch(e){
      rethrow;
    }
  }
}