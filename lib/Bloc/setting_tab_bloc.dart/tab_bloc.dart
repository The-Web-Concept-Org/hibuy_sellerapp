import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_event.dart';
import 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial()) {
    on<TabSelected>((event, emit) {
      emit(TabChanged(event.index));
    });
  }
}
