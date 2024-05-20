import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_demo/modal/beer_response_modal.dart';
import 'package:flutter_application_bloc_demo/services/exception/exception.dart';
import 'package:flutter_application_bloc_demo/services/repo/repos.dart';
import 'package:meta/meta.dart';

part 'pagination_screen_event.dart';
part 'pagination_screen_state.dart';

class PaginationScreenBloc
    extends Bloc<PaginationScreenEvent, PaginationScreenState> {
  int pageNumber = 0;
  bool hasMore = true;
  List<BeerResponseModal> myBeerList = [];
  PaginationScreenBloc() : super(PaginationScreenInitial()) {
    on<PaginationScreenFetchDataEvent>(paginationScreenFetchDataEvent);
  }

  FutureOr<void> paginationScreenFetchDataEvent(
      PaginationScreenFetchDataEvent event,
      Emitter<PaginationScreenState> emit) async {
    if (pageNumber == 0) {
      emit(PaginationScreenLoadingState());
    }
    try {
      pageNumber = pageNumber + 1;
      var data = await paginationRepo.getMyBeers(pageNumber);
      if (data.length < 10) {
        hasMore = false;
      }
      log('my data: $data ');
      if (data.isNotEmpty) {
        myBeerList.addAll(data);
        log('list lenght: $myBeerList ');
      } else {
        log(' error list lenght: $myBeerList ');
      }

      emit(
          PaginationScreenSuccessState(beerList: myBeerList, hasMore: hasMore));
    } on RepoException catch (e) {
      emit(PaginationScreenErrorState(message: e.message.toString()));
    } catch (e) {
      emit(PaginationScreenErrorState(message: e.toString()));
    }
  }
}
