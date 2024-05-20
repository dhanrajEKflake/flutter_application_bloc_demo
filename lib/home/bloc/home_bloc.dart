import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_bloc_demo/data/my_cart_list_data.dart';
import 'package:flutter_application_bloc_demo/data/my_fruits_list_data.dart';
import 'package:flutter_application_bloc_demo/modal/fruit_modal.dart';
import 'package:flutter_application_bloc_demo/services/auth.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final Cartdata cartdata = Cartdata();

  final User? user = Auth().currentUser;
  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadFruitsDataEvent>(homeLoadFruitsDataEvent);
    on<HomeAddtoCartEvent>(homeAddtoCartEvent);
    on<HomeErrorEvent>(homeErrorEvent);
    on<HomeNavigateToCartEvent>(homeNavigateToCartEvent);
    on<HomeLogoutEvent>(homeLogoutEvent);
    on<HomeVerifyEmailEvent>(homeVerifyEmailEvent);
  }

  FutureOr<void> homeAddtoCartEvent(
      HomeAddtoCartEvent event, Emitter<HomeState> emit) {
    if (cartList.contains(event.myFruit)) {
      emit(HomeAddedtoCartState(message: 'Already added in cart'));
    } else {
      cartList.add(event.myFruit);
      emit(HomeAddedtoCartState(message: 'Fruit added to cart'));
    }
  }

  FutureOr<void> homeLoadFruitsDataEvent(
      HomeLoadFruitsDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeSuccessState(fruitsList: FruitsData.fruitsList));
  }

  FutureOr<void> homeErrorEvent(HomeErrorEvent event, Emitter<HomeState> emit) {
    emit(HomeErrorState(message: 'Error Please try again'));
  }

  FutureOr<void> homeNavigateToCartEvent(
      HomeNavigateToCartEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartState());
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  FutureOr<void> homeLogoutEvent(
      HomeLogoutEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    if (user != null) {
      // await Auth()
      await signOut();
      emit(HomeInitial());
    } else {
      emit(HomeErrorState(message: 'Try again'));
    }
  }

  FutureOr<void> homeVerifyEmailEvent(
      HomeVerifyEmailEvent event, Emitter<HomeState> emit) async {
    await Auth().verfyEmail();
    emit(HomeInitial());
  }
}
