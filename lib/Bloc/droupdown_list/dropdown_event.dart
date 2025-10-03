// dropdown_event.dart
import 'package:equatable/equatable.dart';

abstract class DropdownEvent extends Equatable {
  const DropdownEvent();
  @override
  List<Object?> get props => [];
}

class LoadDropdownItems extends DropdownEvent {
  final List<String> items;
  const LoadDropdownItems(this.items);

  @override
  List<Object?> get props => [items];
}

class SelectDropdownItem extends DropdownEvent {
  final String selectedItem;
  const SelectDropdownItem(this.selectedItem);

  @override
  List<Object?> get props => [selectedItem];
}
