import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_demo/modal/meal_modal.dart';
import 'package:flutter_application_bloc_demo/services/repo/repos.dart';
import 'package:meta/meta.dart';
import 'package:youtube_parser/youtube_parser.dart';

part 'meal_details_event.dart';
part 'meal_details_state.dart';

class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  late MealResponseModal mealData;

  MealDetailsBloc() : super(MealDetailsInitial()) {
    on<MealFetchDetailsEvent>(mealFetchDetailsEvent);
    on<MealDetailsPlayButtonPressedEvent>(mealDetailsPlayButtonPressedEvent);
  }

  FutureOr<void> mealFetchDetailsEvent(
      MealFetchDetailsEvent event, Emitter<MealDetailsState> emit) async {
    emit(MealDetailsLoadingState());
    try {
      mealData = await mealRepo.getDetailMealData(mealId: event.mealId);
      if (mealData.meals != null) {
        emit(MealDetailsSuccessState(mealData: mealData));
      } else {
        emit(MealDetailsErrorState(message: 'No Data Found Try Again'));
      }
    } catch (e) {
      emit(MealDetailsErrorState(message: e.toString()));
    }
  }

  FutureOr<void> mealDetailsPlayButtonPressedEvent(
      MealDetailsPlayButtonPressedEvent event, Emitter<MealDetailsState> emit) {
    String? videoID = getIdFromUrl(event.youtubeURL);
    if (videoID != null) {
      log('videoid: $videoID');
      emit(MealDetailsPlayVideoState(youtubeId: videoID));
    } else {
      emit(MealDetailsErrorState(message: 'Cannot Play Video'));
    }
  }
}
