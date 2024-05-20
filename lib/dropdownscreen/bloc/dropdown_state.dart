part of 'dropdown_bloc.dart';

@immutable
sealed class DropdownState {}

final class DropdownInitial extends DropdownState {}

final class DropdownLoadingState extends DropdownState {}

final class DropdownSelectedState extends DropdownState {
  // final String selectedItem;
  final List<Result> myItems;

  DropdownSelectedState({required this.myItems});
}
