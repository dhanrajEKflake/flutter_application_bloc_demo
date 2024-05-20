part of 'meal_bloc.dart';

@immutable
sealed class MealEvent {}

class MealFetchDataEvent extends MealEvent {}
