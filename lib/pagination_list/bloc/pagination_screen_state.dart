part of 'pagination_screen_bloc.dart';

@immutable
sealed class PaginationScreenState {}

final class PaginationScreenInitial extends PaginationScreenState {}

final class PaginationScreenLoadingState extends PaginationScreenState {}

final class PaginationScreenSuccessState extends PaginationScreenState {
  final List<BeerResponseModal> beerList;
  final bool hasMore;

  PaginationScreenSuccessState({required this.beerList, required this.hasMore});
}

final class PaginationScreenErrorState extends PaginationScreenState {
  final String message;

  PaginationScreenErrorState({required this.message});
}
