import 'package:flutter_application_bloc_demo/services/api/api_service.dart';
import 'package:flutter_application_bloc_demo/services/api/api_service_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initService() {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}

ApiService get apiService => getIt.get<ApiService>();
