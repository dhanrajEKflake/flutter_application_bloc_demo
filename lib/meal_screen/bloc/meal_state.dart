part of 'meal_bloc.dart';

@immutable
sealed class MealState {}

final class MealInitial extends MealState {}

final class MealLoadingState extends MealState {}

final class MealSuccessState extends MealState {
  final MealResponseModal mealData;

  MealSuccessState({required this.mealData});
}

final class MealErrorState extends MealState {
  final String message;

  MealErrorState({required this.message});
}
