import 'package:equatable/equatable.dart';

abstract class StepEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StepChangedEvent extends StepEvent {
  final int stepIndex;

  StepChangedEvent(this.stepIndex);

  @override
  List<Object> get props => [stepIndex];
}
