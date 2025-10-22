import 'package:equatable/equatable.dart';

enum AddProductStatus { initial, loading, success, error }

class AddProductState extends Equatable {
  final AddProductStatus status;
  final String? message;

  const AddProductState({
    this.status = AddProductStatus.initial,
    this.message,
  });

  AddProductState copyWith({
    AddProductStatus? status,
    String? message,
  }) {
    return AddProductState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
