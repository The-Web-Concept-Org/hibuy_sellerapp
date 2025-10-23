import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(const VariantState()) {
    on<AddVariantEvent>(_onAddVariant);
    on<UpdateVariantEvent>(_onUpdateVariant);
    on<DeleteVariantEvent>(_onDeleteVariant);
    on<ClearVariantsEvent>(_onClearVariants);
    on<UpdateVariantDataEvent>(_onUpdateVariantData);
  }

  /// 🟩 Add a new variant (e.g., Size, Color)
  void _onAddVariant(AddVariantEvent event, Emitter<VariantState> emit) {
    // Validation
    if (event.optionName.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Option name cannot be empty'));
      return;
    }

    if (event.values.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please add at least one value'));
      return;
    }

    // Limit: Max 2 variant levels
    if (state.variants.length >= 2) {
      emit(state.copyWith(errorMessage: 'Maximum 2 variants allowed'));
      return;
    }

    // Prevent duplicate variant names
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

    final updatedData =
        Map<String, Map<String, dynamic>>.from(state.variantCombinations);

    // ✅ Handle combination creation
    if (state.variants.isEmpty) {
      // First variant only
      for (var value in event.values) {
        updatedData[value] = updatedData[value] ??
            {'price': '', 'stock': '', 'image': null};
      }
    } else if (state.variants.length == 1) {
      // Second variant added: build combinations
      final firstVariant = state.variants[0];
      for (var firstValue in firstVariant.values) {
        for (var secondValue in event.values) {
          final key = '$firstValue-$secondValue';
          updatedData[key] = updatedData[key] ??
              {'price': '', 'stock': '', 'image': null};
        }
      }
    }

    emit(state.copyWith(
      variants: newVariants,
      variantCombinations: updatedData,
      errorMessage: null,
    ));
  }

  /// 🟨 Update existing variant (values or name)
  void _onUpdateVariant(UpdateVariantEvent event, Emitter<VariantState> emit) {
    if (event.index < 0 || event.index >= state.variants.length) return;

    final newVariants = List<VariantModel>.from(state.variants);
    final oldVariant = newVariants[event.index];
    newVariants[event.index] = VariantModel(
      optionName: event.optionName,
      values: event.values,
    );

    final updatedData =
        Map<String, Map<String, dynamic>>.from(state.variantCombinations);

    if (state.variants.length == 1) {
      // Single variant only
      for (var oldValue in oldVariant.values) {
        updatedData.remove(oldValue);
      }
      for (var newValue in event.values) {
        updatedData[newValue] =
            updatedData[newValue] ?? {'price': '', 'stock': '', 'image': null};
      }
    } else if (state.variants.length == 2) {
      // Two variants (combinations)
      if (event.index == 0) {
        // Updated first variant
        final secondVariant = state.variants[1];

        // Remove old combinations
        for (var oldValue in oldVariant.values) {
          updatedData.remove(oldValue);
          for (var secondValue in secondVariant.values) {
            updatedData.remove('$oldValue-$secondValue');
          }
        }

        // Add new combinations
        for (var newValue in event.values) {
          updatedData[newValue] =
              updatedData[newValue] ?? {'price': '', 'stock': '', 'image': null};
          for (var secondValue in secondVariant.values) {
            final key = '$newValue-$secondValue';
            updatedData[key] =
                updatedData[key] ?? {'price': '', 'stock': '', 'image': null};
          }
        }
      } else {
        // Updated second variant
        final firstVariant = state.variants[0];

        // Remove old keys
        for (var firstValue in firstVariant.values) {
          for (var oldValue in oldVariant.values) {
            updatedData.remove('$firstValue-$oldValue');
          }
        }

        // Add new combinations
        for (var firstValue in firstVariant.values) {
          for (var newValue in event.values) {
            final key = '$firstValue-$newValue';
            updatedData[key] =
                updatedData[key] ?? {'price': '', 'stock': '', 'image': null};
          }
        }
      }
    }

    emit(state.copyWith(
      variants: newVariants,
      variantCombinations: updatedData,
      errorMessage: null,
    ));
  }

  /// 🟥 Delete a variant (and cleanup data)
  void _onDeleteVariant(DeleteVariantEvent event, Emitter<VariantState> emit) {
    if (event.index < 0 || event.index >= state.variants.length) return;

    final newVariants = List<VariantModel>.from(state.variants)
      ..removeAt(event.index);

    final updatedData =
        Map<String, Map<String, dynamic>>.from(state.variantCombinations);

    if (newVariants.isEmpty) {
      // No variants left
      updatedData.clear();
    } else if (state.variants.length == 2 && newVariants.length == 1) {
      // Transition from 2 → 1 variant
      final remainingVariant = newVariants[0];
      updatedData.clear();

      for (var value in remainingVariant.values) {
        updatedData[value] = {'price': '', 'stock': '', 'image': null};
      }
    }

    emit(state.copyWith(
      variants: newVariants,
      variantCombinations: updatedData,
      errorMessage: null,
    ));
  }

  /// 🔄 Clear all variants
  void _onClearVariants(ClearVariantsEvent event, Emitter<VariantState> emit) {
    emit(const VariantState());
  }

  /// ✏️ Update specific variant combination (price, stock, image)
  void _onUpdateVariantData(
    UpdateVariantDataEvent event,
    Emitter<VariantState> emit,
  ) {
    final updatedData =
        Map<String, Map<String, dynamic>>.from(state.variantCombinations);

    updatedData[event.key] = {
      ...?updatedData[event.key],
      ...event.data,
    };

    emit(state.copyWith(variantCombinations: updatedData));
  }
}
