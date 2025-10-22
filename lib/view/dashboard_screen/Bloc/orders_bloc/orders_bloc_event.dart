part of 'orders_bloc_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersEvent extends OrdersEvent {
  const GetOrdersEvent();

  @override
  List<Object> get props => [];
}

class SetCurrentOrder extends OrdersEvent {
  final OrderData currentOrder;
  const SetCurrentOrder(this.currentOrder);

  @override
  List<Object> get props => [currentOrder];
}

