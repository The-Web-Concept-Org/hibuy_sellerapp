part of 'orders_bloc_bloc.dart';

enum OrdersStatus { initial, loading, success, error }

class OrdersState extends Equatable {
  final String? message;
  final String filterStatus;
  final OrdersStatus? status;
  final OrdersResponse? ordersResponse;
  final String filterStartDate;
  final String? errorMessage;
  final String filterEndDate;
  const OrdersState({
    this.message,
    this.status,
    this.ordersResponse,
    this.errorMessage,
    this.filterStatus = "order_placed",
    this.filterStartDate = "2025-10-18",
    this.filterEndDate = "2025-10-22",
  });

  OrdersState copyWith({
    final String? filterStatus,
    final String? errorMessage,
    final String? filterStartDate,
    final String? filterEndDate,
    OrdersStatus? status,
    OrdersResponse? ordersResponse,
    String? message,
  }) {
    return OrdersState(
      filterStatus: filterStatus ?? this.filterStatus,
      filterStartDate: filterStartDate ?? this.filterStartDate,
      filterEndDate: filterEndDate ?? this.filterEndDate,
      status: status ?? this.status,
      ordersResponse: ordersResponse ?? this.ordersResponse,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [message, status];
}
