import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/vechicle_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/services/api_service.dart';
import 'vehicle_type_event.dart';
import 'vehicle_type_state.dart';

class VehicleTypeBloc extends Bloc<VehicleTypeEvent, VehicleTypeState> {
  VehicleTypeBloc() : super(const VehicleTypeState()) {
    on<FetchVehicleTypeEvent>(_onFetchVehicleTypeEvent);
  }

  Future<void> _onFetchVehicleTypeEvent(
      FetchVehicleTypeEvent event, Emitter<VehicleTypeState> emit) async {
    emit(state.copyWith(status: VehicleTypeStatus.loading));

    try {
      await ApiService.getMethod(
        authHeader: true,
        apiUrl: AppUrl.getVehicleTypes,
        executionMethod: (bool success, dynamic responseData) {
          if (success) {
            log("✅ Vehicle Type Response: $responseData");
            final vehicleTypeModel = VehicleType.fromJson(responseData);
            emit(state.copyWith(
              status: VehicleTypeStatus.success,
              vehicleType: vehicleTypeModel,
              message: "Vehicle types fetched successfully",
            ));
          } else {
            emit(state.copyWith(
              status: VehicleTypeStatus.error,
              message: responseData['message'] ?? "Failed to fetch vehicle types",
            ));
          }
        },
      );
    } catch (e, st) {
      log("❌ Vehicle Type Error: $e", stackTrace: st);
      emit(state.copyWith(
        status: VehicleTypeStatus.error,
        message: e.toString(),
      ));
    }
  }
}
