part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartFetchCartItemsEvent extends CartEvent {}

class CartRemoveItemEvent extends CartEvent {
  final FruitModal myFruit;

  CartRemoveItemEvent({required this.myFruit});
}
