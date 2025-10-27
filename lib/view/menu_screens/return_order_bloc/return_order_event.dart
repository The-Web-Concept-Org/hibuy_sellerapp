part of 'return_order_bloc.dart';

abstract class ReturnOrderEvent extends Equatable {
  const ReturnOrderEvent();

  @override
  List<Object> get props => [];
}

class GetReturnOrdersEvent extends ReturnOrderEvent {
  const GetReturnOrdersEvent();
}

class GetReturnOrderDetailEvent extends ReturnOrderEvent {
  final String returnOrderId;
  const GetReturnOrderDetailEvent(this.returnOrderId);

  @override
  List<Object> get props => [returnOrderId];
}

class SetCurrentReturnOrder extends ReturnOrderEvent {
  final ReturnOrderModel currentReturnOrder;
  const SetCurrentReturnOrder(this.currentReturnOrder);

  @override
  List<Object> get props => [currentReturnOrder];
}

class SearchReturnOrdersEvent extends ReturnOrderEvent {
  final String searchQuery;
  const SearchReturnOrdersEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}
class UpdateReturnOrdersEvent extends ReturnOrderEvent {
  final String returnOrderId;
  final String status;
  const UpdateReturnOrdersEvent(this.returnOrderId, this.status);

  @override
  List<Object> get props => [returnOrderId, status];
}

class ClearReturnDataEvent extends ReturnOrderEvent {
  const ClearReturnDataEvent();

  @override
  List<Object> get props => [];
}
