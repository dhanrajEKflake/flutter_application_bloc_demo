import 'package:flutter_application_bloc_demo/services/repo/meals/meal_repo.dart';
import 'package:flutter_application_bloc_demo/services/repo/meals/meal_repo_impl.dart';
import 'package:flutter_application_bloc_demo/services/repo/pagination_repos/pagination_repo.dart';
import 'package:flutter_application_bloc_demo/services/repo/pagination_repos/pagination_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initRepo() {
  getIt.registerLazySingleton<MealRepo>(() => MealRepoImpl());
  getIt.registerLazySingleton<PaginationRepo>(() => PaginationRepoImpl());
}

MealRepo get mealRepo => getIt.get<MealRepo>();
PaginationRepo get paginationRepo => getIt.get<PaginationRepo>();
