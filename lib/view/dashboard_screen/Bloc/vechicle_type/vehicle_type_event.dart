import 'package:equatable/equatable.dart';

abstract class VehicleTypeEvent extends Equatable {
  const VehicleTypeEvent();

  @override
  List<Object?> get props => [];
}

class FetchVehicleTypeEvent extends VehicleTypeEvent {}
