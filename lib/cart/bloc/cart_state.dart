part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSuccessState extends CartState {
  final List<FruitModal> cartList;
  final double totalAmount;

  CartSuccessState({required this.cartList, required this.totalAmount});
}

final class CartErrorState extends CartState {}
