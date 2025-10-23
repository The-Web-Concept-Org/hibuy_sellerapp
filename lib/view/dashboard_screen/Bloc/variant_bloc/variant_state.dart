// variant_state.dart
import 'package:equatable/equatable.dart';

class VariantModel {
  final String optionName;
  final List<String> values;

  VariantModel({
    required this.optionName,
    required this.values,
  });

  @override
  String toString() => 'VariantModel(optionName: $optionName, values: $values)';
}

class VariantState extends Equatable {
  final List<VariantModel> variants;
  final String? errorMessage;
  final Map<String, Map<String, dynamic>> variantCombinations;

  const VariantState({
    this.variants = const [],
    this.errorMessage,
    this.variantCombinations = const {},
  });

  VariantState copyWith({
    List<VariantModel>? variants,
    String? errorMessage,
    Map<String, Map<String, dynamic>>? variantCombinations,
  }) {
    return VariantState(
      variants: variants ?? this.variants,
      errorMessage: errorMessage,
      variantCombinations: variantCombinations ?? this.variantCombinations,
    );
  }

  @override
  List<Object?> get props => [variants, errorMessage, variantCombinations];

  @override
  String toString() => 'VariantState(variants: $variants, errorMessage: $errorMessage, variantCombinations: $variantCombinations)';
}