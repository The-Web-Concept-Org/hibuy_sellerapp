import 'package:equatable/equatable.dart';
import 'package:hibuy/models/store_update_model.dart';

enum StoreUpdateStatus { initial, loading, success, error }

class StoreUpdateState extends Equatable {
  final String? message;
  final StoreUpdate? storeUpdate;
  final StoreUpdateStatus status;

  const StoreUpdateState({
    this.message,
    this.storeUpdate,
    this.status = StoreUpdateStatus.initial,
  });

  StoreUpdateState copyWith({
    String? message,
    StoreUpdate? storeUpdate,
    StoreUpdateStatus? status,
  }) {
    return StoreUpdateState(
      message: message ?? this.message,
      storeUpdate: storeUpdate ?? this.storeUpdate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [message, storeUpdate, status];
}
