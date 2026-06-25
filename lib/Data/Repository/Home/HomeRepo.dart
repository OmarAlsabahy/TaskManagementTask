import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasks_management_system/Data/Api/ApiHandler.dart';
import 'package:tasks_management_system/Data/Api/AppPaths.dart';
import 'package:tasks_management_system/Data/Database/AppDatabase.dart';
import 'package:tasks_management_system/Domain/Models/projects_response.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IHomeRepo.dart';

class HomeRepo extends IHomeRepo{
  ApiHandler _apiHandler;
  AppDatabase _database;
  HomeRepo(this._apiHandler,this._database);
  @override
  Future<Either<List<ProjectsResponse>, String>> getProjects() async{
    try{
      final result = await _apiHandler.get(AppPaths.projects);
      final projects = ((result.data) as List).map((item)=>ProjectsResponse.fromJson(item)).toList();
      for(var project in projects){
        await _database.insertProject(project);
      }
      return Left(projects);
    }on DioException catch(e){
      if(e.response?.statusCode==401){
        await _apiHandler.refreshToken();
      }else{
        final result = await _database.getAllProjects();
        return Left(result);
      }
      return Right(e.toString());
    }catch(e){
      final result = await _database.getAllProjects();
      return Left(result);
    }
  }

}