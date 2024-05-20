import 'package:flutter_application_bloc_demo/services/api/api_response.dart';

abstract class ApiService {
  void init({required String baseUrl});

  Future<ApiResponse> get({required String path, Map<String, dynamic>? query});
  Future<ApiResponse> post({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}
