// variant_event.dart
abstract class VariantEvent {}

class AddVariantEvent extends VariantEvent {
  final String optionName;
  final List<String> values;

  AddVariantEvent(this.optionName, this.values);
}

class UpdateVariantEvent extends VariantEvent {
  final int index;
  final String optionName;
  final List<String> values;

  UpdateVariantEvent(this.index, this.optionName, this.values);
}

class DeleteVariantEvent extends VariantEvent {
  final int index;

  DeleteVariantEvent(this.index);
}

class ClearVariantsEvent extends VariantEvent {}