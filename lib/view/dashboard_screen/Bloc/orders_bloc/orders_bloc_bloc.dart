import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_bloc_event.dart';
part 'orders_bloc_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on<OrdersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
