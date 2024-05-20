part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<FruitModal> fruitsList;

  HomeSuccessState({required this.fruitsList});
}

final class HomeAddedtoCartState extends HomeState {
  final String message;

  HomeAddedtoCartState({required this.message});
}

final class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}

final class HomeNavigateToCartState extends HomeState {}
