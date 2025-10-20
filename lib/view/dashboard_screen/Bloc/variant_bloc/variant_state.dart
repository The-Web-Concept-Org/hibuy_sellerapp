// variant_state.dart
class VariantModel {
  final String optionName;
  final List<String> values;

  VariantModel({
    required this.optionName,
    required this.values,
  });

  VariantModel copyWith({
    String? optionName,
    List<String>? values,
  }) {
    return VariantModel(
      optionName: optionName ?? this.optionName,
      values: values ?? this.values,
    );
  }
}

class VariantState {
  final List<VariantModel> variants;
  final String? errorMessage;

  VariantState({
    this.variants = const [],
    this.errorMessage,
  });

  VariantState copyWith({
    List<VariantModel>? variants,
    String? errorMessage,
  }) {
    return VariantState(
      variants: variants ?? this.variants,
      errorMessage: errorMessage,
    );
  }
}
