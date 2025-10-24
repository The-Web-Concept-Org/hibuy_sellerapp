part of 'setting_bloc.dart';

enum SettingStatus { initial, loading, success, error }

enum SavingProfileStatus { initial, loading, success, error }

enum UpdatePasswordStatus { initial, loading, success, error }

class SettingState extends Equatable {
  final String? message;
  final SettingStatus? status;
  final SavingProfileStatus? savingDataStatus;
  final UpdatePasswordStatus? updatePasswordStatus;
  final SellerDetails? sellerDetails;
  const SettingState({
    this.savingDataStatus = SavingProfileStatus.initial,
    this.message,
    this.status,
    this.sellerDetails,
    this.updatePasswordStatus = UpdatePasswordStatus.initial,
  });

  SettingState copyWith({
    SettingStatus? status,
    String? message,
    SavingProfileStatus? savingDataStatus,
    SellerDetails? sellerDetails,
    UpdatePasswordStatus? updatePasswordStatus,
  }) {
    return SettingState(
      updatePasswordStatus: updatePasswordStatus ?? this.updatePasswordStatus,
      status: status ?? this.status,
      savingDataStatus: savingDataStatus ?? this.savingDataStatus,
      sellerDetails: sellerDetails ?? this.sellerDetails,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
    savingDataStatus,
    updatePasswordStatus,
    sellerDetails,
  ];
}
