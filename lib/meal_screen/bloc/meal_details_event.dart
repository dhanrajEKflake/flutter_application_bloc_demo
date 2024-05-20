part of 'meal_details_bloc.dart';

@immutable
sealed class MealDetailsEvent {}

class MealFetchDetailsEvent extends MealDetailsEvent {
  final int mealId;

  MealFetchDetailsEvent({required this.mealId});
}

class MealDetailsPlayButtonPressedEvent extends MealDetailsEvent {
  final String youtubeURL;

  MealDetailsPlayButtonPressedEvent({required this.youtubeURL});
}
