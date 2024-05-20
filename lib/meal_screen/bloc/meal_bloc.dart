import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_demo/modal/meal_modal.dart';
import 'package:flutter_application_bloc_demo/services/repo/repos.dart';
import 'package:meta/meta.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  late MealResponseModal mealData;

  MealBloc() : super(MealInitial()) {
    on<MealFetchDataEvent>(mealFetchDataEvent);
  }

  FutureOr<void> mealFetchDataEvent(
      MealFetchDataEvent event, Emitter<MealState> emit) async {
    emit(MealLoadingState());
    try {
      mealData = await mealRepo.getrandomMealData();
      emit(MealSuccessState(mealData: mealData));
    } catch (e) {
      emit(MealErrorState(message: e.toString()));
    }
  }
}
