import 'package:equatable/equatable.dart';

abstract class StepState extends Equatable {
  @override
  List<Object> get props => [];
}

class StepInitialState extends StepState {}

class StepSelectedState extends StepState {
  final int selectedStep;

  StepSelectedState(this.selectedStep);

  @override
  List<Object> get props => [selectedStep];
}
