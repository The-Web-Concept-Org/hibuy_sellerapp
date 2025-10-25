part of 'boost_menu_bloc.dart';

enum BoostMenuStatus { initial, loading, success, error }

class BoostMenuState extends Equatable {
  final String? message;
  final BoostMenuStatus? status;
  final bool isBoosted;
  final BoostStatus? boostStatus;

  const BoostMenuState({
    this.message,
    this.status,
    this.isBoosted = false,
    this.boostStatus,
  });

  BoostMenuState copyWith({
    BoostMenuStatus? status,
    String? message,
    bool? isBoosted,
    BoostStatus? boostStatus,
  }) {
    return BoostMenuState(
      status: status ?? this.status,
      message: message ?? this.message,
      isBoosted: isBoosted ?? this.isBoosted,
      boostStatus: boostStatus ?? this.boostStatus,
    );
  }

  @override
  List<Object?> get props => [message, status, isBoosted, boostStatus];
}
