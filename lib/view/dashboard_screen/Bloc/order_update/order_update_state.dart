part of 'order_update_bloc.dart';

enum OrderUpdateStatus { initial, loading, success, error }



enum GetOrderStatus { initial, loading, success, error }

class OrderUpdateState extends Equatable {
  final OrderUpdateStatus? orderUpdateStatus;
  final String? message;
  final String? errorMessage;
  final GetOrderStatus? status;
  final OrderData? ordersResponse;

  final OrderData? currentOrder;
  const OrderUpdateState({
    this.orderUpdateStatus,
    this.currentOrder,
    this.message,
    this.status,
    this.ordersResponse,
    this.errorMessage,
    t
  });

  OrderUpdateState copyWith({
    final String? errorMessage,
    String? message,
    OrderUpdateStatus? orderUpdateStatus,
    GetOrderStatus? status,
    OrderData? ordersResponse,
    OrderData? currentOrder,
  }) {
    return OrderUpdateState(
         message: message ?? this.message,
      orderUpdateStatus: orderUpdateStatus ?? this.orderUpdateStatus,
      status: status ?? this.status,
      currentOrder: currentOrder ?? this.currentOrder,
      ordersResponse: ordersResponse ?? this.ordersResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [message, status];
}
