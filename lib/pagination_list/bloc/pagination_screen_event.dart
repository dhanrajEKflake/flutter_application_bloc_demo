part of 'pagination_screen_bloc.dart';

@immutable
sealed class PaginationScreenEvent {}

class PaginationScreenFetchDataEvent extends PaginationScreenEvent {}
