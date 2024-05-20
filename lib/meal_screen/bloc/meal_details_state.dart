part of 'meal_details_bloc.dart';

@immutable
sealed class MealDetailsState {}

final class MealDetailsInitial extends MealDetailsState {}

final class MealDetailsLoadingState extends MealDetailsState {}

final class MealDetailsSuccessState extends MealDetailsState {
  final MealResponseModal mealData;

  MealDetailsSuccessState({required this.mealData});
}

final class MealDetailsErrorState extends MealDetailsState {
  final String message;

  MealDetailsErrorState({required this.message});
}

final class MealDetailsPlayVideoState extends MealDetailsState {
  final String youtubeId;

  MealDetailsPlayVideoState({required this.youtubeId});
}
