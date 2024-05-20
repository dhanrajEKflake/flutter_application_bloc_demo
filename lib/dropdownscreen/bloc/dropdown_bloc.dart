import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_demo/dropdownscreen/modals/item_modal.dart';
import 'package:meta/meta.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  String mySelectedItem = 'Item 1';

  List<Result> myItems = [
    // 'Item 1',
    Result(id: 1, name: 'Item 1'),
    Result(id: 2, name: 'Item 2'),
    Result(id: 3, name: 'Item 3'),
    Result(id: 4, name: 'Item 4'),
  ];

  DropdownBloc() : super(DropdownInitial()) {
    on<LoadItemEvent>(loadItemEvent);
  }

  FutureOr<void> loadItemEvent(
      LoadItemEvent event, Emitter<DropdownState> emit) {
    emit(DropdownLoadingState());
    emit(DropdownSelectedState(myItems: myItems));
  }
}
