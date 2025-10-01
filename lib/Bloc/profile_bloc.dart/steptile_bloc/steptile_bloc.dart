import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_event.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_state.dart';

class StepBloc extends Bloc<StepEvent, StepState> {
  StepBloc() : super(StepInitialState()) {
    on<StepChangedEvent>((event, emit) {
      emit(StepSelectedState(event.stepIndex));
    });
  }
}
