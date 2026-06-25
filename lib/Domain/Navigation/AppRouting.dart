import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_management_system/Domain/Di/Di.dart';
import 'package:tasks_management_system/Domain/Navigation/AppRoutes.dart';
import 'package:tasks_management_system/Presentation/Auth/StateManagement/Auth/Login/LoginCubit.dart';
import 'package:tasks_management_system/Presentation/Home/Screens/ProjectDetailsScreen.dart';
import 'package:tasks_management_system/Presentation/Main/MainScreen.dart';
import 'package:tasks_management_system/Presentation/Splash/Screens/SplashScreen.dart';
import '../../Presentation/Auth/Screens/LoginScreen.dart';
import '../../Presentation/Home/StateManagement/Projects/ProjectCubit.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => SplashScreen(sharedPrf: getIt()),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: LoginScreen(sharedPrf: getIt()),
      ),
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.projectDetailsScreen,
      builder: (context, state) {
        final projectId = state.extra as int;
        return BlocProvider(
          create: (context) => getIt<ProjectCubit>(),
          child: ProjectDetailsScreen(projectId),
        );
      },
    ),
  ],
);
