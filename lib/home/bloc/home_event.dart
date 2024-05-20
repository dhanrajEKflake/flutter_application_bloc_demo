part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeLoadFruitsDataEvent extends HomeEvent {}

class HomeAddtoCartEvent extends HomeEvent {
  final FruitModal myFruit;

  HomeAddtoCartEvent({required this.myFruit});
}

class HomeNavigateToCartEvent extends HomeEvent {}

class HomeErrorEvent extends HomeEvent {}

class HomeVerifyEmailEvent extends HomeEvent {}

class HomeLogoutEvent extends HomeEvent {}
