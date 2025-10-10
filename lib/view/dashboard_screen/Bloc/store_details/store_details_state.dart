import 'package:equatable/equatable.dart';
import 'package:hibuy/models/store_details_model.dart';

enum StoreDetailsStatus { initial, loading, success, error }

class StoreDetailState extends Equatable {
  final String? message;
  final StoreDetailsModel? storeDetailsModel;
  final StoreDetailsStatus storeDetailsStatus;

  const StoreDetailState({
    this.message,
    this.storeDetailsModel,
    this.storeDetailsStatus = StoreDetailsStatus.initial,
  });

  StoreDetailState copyWith({
    String? message,
    StoreDetailsModel? storeDetailsModel,
    StoreDetailsStatus? storeDetailsStatus,
  }) {
    return StoreDetailState(
      message: message ?? this.message,
      storeDetailsModel: storeDetailsModel ?? this.storeDetailsModel,
      storeDetailsStatus: storeDetailsStatus ?? this.storeDetailsStatus,
    );
  }

  @override
  List<Object?> get props => [
        message,
        storeDetailsModel,
        storeDetailsStatus,
      ];
}
