import 'package:equatable/equatable.dart';

abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object?> get props => [];
}

class TabInitial extends TabState {}

class TabChanged extends TabState {
  final int selectedIndex;

  const TabChanged(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}
