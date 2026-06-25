import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_management_system/Data/Api/ApiHandler.dart';
import 'package:tasks_management_system/Data/Api/AppPaths.dart';
import 'package:tasks_management_system/Domain/Models/profile_response.dart';
import 'package:tasks_management_system/Domain/Repositories/Profile/IProfileRepo.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrfKeys.dart';

class ProfileRepo extends IProfileRepo {
  ApiHandler _apiHandler;
  SharedPrf _sharedPrf;
  ProfileRepo(this._apiHandler,this._sharedPrf);

  @override
  Future<Either<ProfileResponse, String>> getProfile() async {
    try {
      final result = await _apiHandler.get(AppPaths.profile);
      final response = ProfileResponse.fromJson(result.data);
      return Left(response);
    } on DioException catch (e) {
      return Right(e.message ?? "Network error");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> logout()async{
    try{
      await _sharedPrf.delete(SharedPrfKeys.accessToken);
      await _sharedPrf.delete(SharedPrfKeys.refreshToken);
    }catch(e){
      rethrow;
    }
  }
}
