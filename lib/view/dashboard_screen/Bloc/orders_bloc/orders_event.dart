part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersEvent extends OrdersEvent {
  final String? status;
  final String? fromDate;
  final String? toDate;
  const GetOrdersEvent({this.status, this.fromDate, this.toDate});

  @override
  List<Object> get props => [];
}

class SetCurrentOrder extends OrdersEvent {
  final OrderData currentOrder;
  const SetCurrentOrder(this.currentOrder);

  @override
  List<Object> get props => [currentOrder];
}

class ApplyFilterEvent extends OrdersEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final String orderStatus;
  const ApplyFilterEvent({
    required this.fromDate,
    required this.toDate,
    required this.orderStatus,
  });

  @override
  List<Object> get props => [fromDate, toDate, orderStatus];
}

class SearchOrdersEvent extends OrdersEvent {
  final String searchQuery;
  const SearchOrdersEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}
class ClearDataEvent extends OrdersEvent {
  const ClearDataEvent();

  @override
  List<Object> get props => [];
}
