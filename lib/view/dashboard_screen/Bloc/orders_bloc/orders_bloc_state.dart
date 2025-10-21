part of 'orders_bloc_bloc.dart';

enum OrdersStatus { initial, loading, success, error }

class OrdersState extends Equatable {
  final String? message;
  final OrdersStatus? status;
  const OrdersState({this.message, this.status});

  @override
  List<Object?> get props => [message, status];
}
