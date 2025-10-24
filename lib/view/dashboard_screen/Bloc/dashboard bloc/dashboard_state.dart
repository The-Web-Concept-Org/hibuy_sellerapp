part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, success, error }




class DashboardState extends Equatable {
  final DashboardResponse? dashboardResponse;
  final String? message;
  final String? errorMessage;
  final DashBoardStatus? status;
 

  final OrderData? currentOrder;
  const DashboardState({
    this.dashboardResponse,
    this.currentOrder,
    this.message,
    this.status,
    this.errorMessage,
    t
  });

  DashboardState copyWith({
    final String? errorMessage,
    String? message,
    DashboardResponse? dashboardResponse,
    DashBoardStatus? status,
    OrderData? currentOrder,
  }) {
    return DashboardState(
         message: message ?? this.message,
      dashboardResponse: dashboardResponse ?? this.dashboardResponse,
      status: status ?? this.status,
      currentOrder: currentOrder ?? this.currentOrder,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [message, status];
}
