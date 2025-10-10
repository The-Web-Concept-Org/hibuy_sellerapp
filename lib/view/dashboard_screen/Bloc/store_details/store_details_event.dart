import 'package:equatable/equatable.dart';

abstract class StoreDetailsEvent extends Equatable {
  const StoreDetailsEvent();

  @override
  List<Object?> get props => [];
}

class StoreEvent extends StoreDetailsEvent {}
