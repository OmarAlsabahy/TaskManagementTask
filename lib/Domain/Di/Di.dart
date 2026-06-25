import 'package:get_it/get_it.dart';
import 'package:tasks_management_system/Data/Api/ApiHandler.dart';
import 'package:tasks_management_system/Data/Database/AppDatabase.dart';
import 'package:tasks_management_system/Data/Repository/Auth/LoginRepo.dart';
import 'package:tasks_management_system/Data/Repository/Home/HomeRepo.dart';
import 'package:tasks_management_system/Data/Repository/Home/ProjectDetailsRepo.dart';
import 'package:tasks_management_system/Data/Repository/Profile/ProfileRepo.dart';
import 'package:tasks_management_system/Domain/Repositories/Auth/ILoginRepo.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IHomeRepo.dart';
import 'package:tasks_management_system/Domain/Repositories/Home/IProjectDetailsRepo.dart';
import 'package:tasks_management_system/Domain/Repositories/Profile/IProfileRepo.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';
import 'package:tasks_management_system/Presentation/Auth/StateManagement/Auth/Login/LoginCubit.dart';
import 'package:tasks_management_system/Presentation/Home/StateManagement/Projects/ProjectCubit.dart';
import 'package:tasks_management_system/Presentation/Profile/StateManagement/Profile/ProfileCubit.dart';

import '../../Presentation/Home/StateManagement/Home/HomeCubit.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiHandler>(()=>ApiHandler(sharedPrf: getIt()));
  getIt.registerLazySingleton<AppDatabase>(()=>AppDatabase());
  getIt.registerLazySingleton<ILoginRepo>(()=>LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(()=>LoginCubit(getIt()));
  getIt.registerLazySingleton<SharedPrf>(()=>SharedPrf());
  getIt.registerLazySingleton<IHomeRepo>(()=>HomeRepo(getIt(),getIt()));
  getIt.registerFactory<HomeCubit>(()=>HomeCubit(getIt()));
  getIt.registerLazySingleton<IProjectDetailsRepo>(()=>ProjectDetailsRepo(getIt(),getIt()));
  getIt.registerFactory<ProjectCubit>(()=>ProjectCubit(getIt()));
  getIt.registerLazySingleton<IProfileRepo>(()=>ProfileRepo(getIt(),getIt()));
  getIt.registerFactory<ProfileCubit>(()=>ProfileCubit(getIt()));
}