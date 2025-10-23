import 'package:equatable/equatable.dart';

/// 🔹 Base class for all Variant events
abstract class VariantEvent extends Equatable {
  const VariantEvent();

  @override
  List<Object?> get props => [];
}

/// ➕ Add a new variant (e.g., Size or Color)
class AddVariantEvent extends VariantEvent {
  final String optionName;
  final List<String> values;

  const AddVariantEvent(this.optionName, this.values);

  @override
  List<Object?> get props => [optionName, values];
}

/// ✏️ Update an existing variant (rename or change values)
class UpdateVariantEvent extends VariantEvent {
  final int index;
  final String optionName;
  final List<String> values;

  const UpdateVariantEvent(this.index, this.optionName, this.values);

  @override
  List<Object?> get props => [index, optionName, values];
}

/// ❌ Delete a variant by index
class DeleteVariantEvent extends VariantEvent {
  final int index;

  const DeleteVariantEvent(this.index);

  @override
  List<Object?> get props => [index];
}

/// 🧹 Clear all variants and combinations
class ClearVariantsEvent extends VariantEvent {
  const ClearVariantsEvent();
}

/// 🔄 Update data for a specific variant key (e.g., price, stock, image)
class UpdateVariantDataEvent extends VariantEvent {
  final String key; // e.g., "Large-Red"
  final Map<String, dynamic> data;

  const UpdateVariantDataEvent(this.key, this.data);

  @override
  List<Object?> get props => [key, data];
}

/// 🖼️ Optional: Clear all variant images (if you add ClearAllImagesEvent logic later)
class ClearAllVariantImagesEvent extends VariantEvent {
  const ClearAllVariantImagesEvent();
}
