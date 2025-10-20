// variant_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(VariantState()) {
    on<AddVariantEvent>(_onAddVariant);
    on<UpdateVariantEvent>(_onUpdateVariant);
    on<DeleteVariantEvent>(_onDeleteVariant);
    on<ClearVariantsEvent>(_onClearVariants);
  }

  void _onAddVariant(AddVariantEvent event, Emitter<VariantState> emit) {
    if (event.optionName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Option name cannot be empty'));
      return;
    }

    if (event.values.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please add at least one value'));
      return;
    }

    // Check if option name already exists
    final exists = state.variants.any(
      (v) => v.optionName.toLowerCase() == event.optionName.toLowerCase(),
    );

    if (exists) {
      emit(state.copyWith(errorMessage: 'Option name already exists'));
      return;
    }

    final newVariants = List<VariantModel>.from(state.variants)
      ..add(VariantModel(
        optionName: event.optionName,
        values: event.values,
      ));

    emit(state.copyWith(variants: newVariants, errorMessage: null));
  }

  void _onUpdateVariant(UpdateVariantEvent event, Emitter<VariantState> emit) {
    if (event.index < 0 || event.index >= state.variants.length) return;

    final newVariants = List<VariantModel>.from(state.variants);
    newVariants[event.index] = VariantModel(
      optionName: event.optionName,
      values: event.values,
    );

    emit(state.copyWith(variants: newVariants, errorMessage: null));
  }

  void _onDeleteVariant(DeleteVariantEvent event, Emitter<VariantState> emit) {
    if (event.index < 0 || event.index >= state.variants.length) return;

    final newVariants = List<VariantModel>.from(state.variants)
      ..removeAt(event.index);

    emit(state.copyWith(variants: newVariants, errorMessage: null));
  }

  void _onClearVariants(ClearVariantsEvent event, Emitter<VariantState> emit) {
    emit(VariantState());
  }
}
