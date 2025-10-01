import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

class TabSelected extends TabEvent {
  final int index;

  const TabSelected(this.index);

  @override
  List<Object?> get props => [index];
}
