part of 'return_order_bloc.dart';

enum ReturnOrderStatus { initial, loading, success, error }

enum ReturnOrderDetailStatus { initial, loading, success, error }

enum UpdatingOrderDetailStatus { initial, loading, success, error }

class ReturnOrderState extends Equatable {
  final String? message;
  final ReturnOrderStatus? status;
  final ReturnOrderDetailStatus? returnOrderDetailStatus;
  final UpdatingOrderDetailStatus? updatingOrderDetailStatus;
  final ReturnOrdersResponse? returnOrdersResponse;
  final String? errorMessage;

  final ReturnOrderModel? currentReturnOrder;
  final ReturnOrderDetailModel? returnOrderDetail;
  final String searchQuery;

  const ReturnOrderState({
    this.currentReturnOrder,
    this.message,
    this.updatingOrderDetailStatus,
    this.returnOrderDetail,
    this.returnOrderDetailStatus,
    this.status = ReturnOrderStatus.initial,
    this.returnOrdersResponse,
    this.errorMessage,
    this.searchQuery = "",
  });

  ReturnOrderState copyWith({
    final String? searchQuery,
    ReturnOrderStatus? status,
    ReturnOrdersResponse? returnOrdersResponse,
    ReturnOrderModel? currentReturnOrder,
    ReturnOrderDetailModel? returnOrderDetail,
    String? message,
    String? errorMessage,
    ReturnOrderDetailStatus? returnOrderDetailStatus,
    UpdatingOrderDetailStatus? updatingOrderDetailStatus,
  }) {
    return ReturnOrderState(
      returnOrderDetail: returnOrderDetail ?? this.returnOrderDetail,
      updatingOrderDetailStatus:
          updatingOrderDetailStatus ?? this.updatingOrderDetailStatus,
      returnOrderDetailStatus:
          returnOrderDetailStatus ?? this.returnOrderDetailStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      currentReturnOrder: currentReturnOrder ?? this.currentReturnOrder,
      returnOrdersResponse: returnOrdersResponse ?? this.returnOrdersResponse,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
    searchQuery,
    returnOrderDetailStatus,
    returnOrderDetail,
    returnOrdersResponse,
    updatingOrderDetailStatus,
    currentReturnOrder,
    errorMessage,
  ];
}
