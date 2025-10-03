// dropdown_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_event.dart';
import 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial()) {
    on<LoadDropdownItems>(_onLoadDropdownItems);
    on<SelectDropdownItem>(_onSelectDropdownItem);
  }

  void _onLoadDropdownItems(
      LoadDropdownItems event, Emitter<DropdownState> emit) {
    emit(DropdownLoaded(items: event.items));
  }

  void _onSelectDropdownItem(
      SelectDropdownItem event, Emitter<DropdownState> emit) {
    if (state is DropdownLoaded) {
      final current = state as DropdownLoaded;
      emit(DropdownLoaded(
          items: current.items, selectedItem: event.selectedItem));
    }
  }
}
