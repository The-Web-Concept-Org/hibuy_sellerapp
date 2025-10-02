// dropdown_state.dart
import 'package:equatable/equatable.dart';

abstract class DropdownState extends Equatable {
  const DropdownState();
  @override
  List<Object?> get props => [];
}

class DropdownInitial extends DropdownState {}

class DropdownLoaded extends DropdownState {
  final List<String> items;
  final String? selectedItem;

  const DropdownLoaded({required this.items, this.selectedItem});

  @override
  List<Object?> get props => [items, selectedItem ?? ""]; 
}
