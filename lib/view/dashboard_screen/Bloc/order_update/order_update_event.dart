part of 'order_update_bloc.dart';

sealed class OrderUpdateEvent extends Equatable {
  const OrderUpdateEvent();

  @override
  List<Object> get props => [];
}
class UpdateOrderEvent extends OrderUpdateEvent {
  final String orderId;
  final String delieveryStatus;
  final File orderVideo;
  final String orderSize;
  final String orderWeight;
  const UpdateOrderEvent(this.orderId, this.delieveryStatus, this.orderVideo, this.orderSize, this.orderWeight);

  @override
  List<Object> get props => [orderId, delieveryStatus, orderVideo, orderSize, orderWeight];
}
class GetCompleteOrderEvent extends OrderUpdateEvent {
  final String orderId;

  const GetCompleteOrderEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}
