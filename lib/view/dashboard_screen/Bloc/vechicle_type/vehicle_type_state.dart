import 'package:equatable/equatable.dart';
import 'package:hibuy/models/vechicle_model.dart';


enum VehicleTypeStatus { initial, loading, success, error }

class VehicleTypeState extends Equatable {
  final String? message;
  final VehicleType? vehicleType;
  final VehicleTypeStatus status;

  const VehicleTypeState({
    this.message,
    this.vehicleType,
    this.status = VehicleTypeStatus.initial,
  });

  VehicleTypeState copyWith({
    String? message,
    VehicleType? vehicleType,
    VehicleTypeStatus? status,
  }) {
    return VehicleTypeState(
      message: message ?? this.message,
      vehicleType: vehicleType ?? this.vehicleType,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [message, vehicleType, status];
}
