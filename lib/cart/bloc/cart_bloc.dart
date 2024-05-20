import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/data/my_cart_list_data.dart';
import 'package:flutter_application_bloc_demo/modal/fruit_modal.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  double totalAmount = 0;
  CartBloc() : super(CartInitial()) {
    on<CartFetchCartItemsEvent>(cartFetchCartItemsEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
  }

  FutureOr<void> cartFetchCartItemsEvent(
      CartFetchCartItemsEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    for (var item in cartList) {
      totalAmount = totalAmount + item.price;
    }
    emit(CartSuccessState(cartList: cartList, totalAmount: totalAmount));
  }

  FutureOr<void> cartRemoveItemEvent(
      CartRemoveItemEvent event, Emitter<CartState> emit) {
    totalAmount = totalAmount - event.myFruit.price;
    cartList.remove(event.myFruit);
    emit(CartSuccessState(cartList: cartList, totalAmount: totalAmount));
  }
}
