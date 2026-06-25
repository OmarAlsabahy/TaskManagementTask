import 'package:dartz/dartz.dart';
import 'package:tasks_management_system/Domain/Models/profile_response.dart';

abstract class IProfileRepo {
  Future<Either<ProfileResponse, String>> getProfile();
  Future logout();
}
