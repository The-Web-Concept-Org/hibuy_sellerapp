part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends SettingEvent {
  const GetUserDataEvent();

  @override
  List<Object> get props => [];
}

class CheckOldData extends SettingEvent {
  final SellerDetails sellerDetails;
  const CheckOldData({required this.sellerDetails});

  @override
  List<Object> get props => [sellerDetails];
}

class UpdateProfile extends SettingEvent {
  final File? profileImage;
  final SellerDetails sellerDetails;
  const UpdateProfile({this.profileImage, required this.sellerDetails});

  @override
  List<Object> get props => [sellerDetails, profileImage!];
}
class UpdatePassword extends SettingEvent {
  final String oldpassword;
  final String newPassword;
  final String reenterNewPassword;
  const UpdatePassword({required this.oldpassword, required this.newPassword, required this.reenterNewPassword});

  @override
  List<Object> get props => [oldpassword, newPassword, reenterNewPassword];
}
