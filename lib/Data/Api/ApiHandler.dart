import 'package:dio/dio.dart';
import 'package:tasks_management_system/Data/Api/AppPaths.dart';
import 'package:tasks_management_system/Domain/SharedPrference/SharedPrf.dart';

import '../../Domain/SharedPrference/SharedPrfKeys.dart';

class ApiHandler{
  late Dio dio;
  SharedPrf sharedPrf;

  ApiHandler({required this.sharedPrf}){

    final options = BaseOptions(
      baseUrl: AppPaths.baseUrl
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await sharedPrf.get(SharedPrfKeys.accessToken);
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 &&
            e.requestOptions.path != AppPaths.refresh &&
            e.requestOptions.path != AppPaths.login) {
          try {
            await refreshToken();
            final accessToken = await sharedPrf.get(SharedPrfKeys.accessToken);
            if (accessToken != null) {
              e.requestOptions.headers["Authorization"] = "Bearer $accessToken";
              final response = await dio.fetch(e.requestOptions);
              return handler.resolve(response);
            }
          } catch (refreshError) {
            return handler.next(e);
          }
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> post(String endPoint,
      {Map<String, dynamic>? queryParams = null,
      Map<String, dynamic>? data = null}) async {
    try {
      final result =
          await dio.post(endPoint, queryParameters: queryParams, data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(String endPoint,
      {Map<String, dynamic>? queryParams = null,
      Map<String, dynamic>? data = null}) async {
    try {
      final result =
          await dio.get(endPoint, queryParameters: queryParams, data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endPoint,
      {Map<String, dynamic>? queryParams = null,
      Map<String, dynamic>? data = null}) async {
    try {
      final result =
          await dio.put(endPoint, queryParameters: queryParams, data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await sharedPrf.get(SharedPrfKeys.refreshToken);
      if (refreshToken == null) return;

      final response = await dio.post(AppPaths.refresh, data: {
        'refreshToken': refreshToken,
      });

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        await sharedPrf.save(SharedPrfKeys.accessToken, newAccessToken);
      }
    } catch (e) {
      rethrow;
    }
  }
}