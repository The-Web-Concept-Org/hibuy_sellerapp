import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/models/seller_details.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';
import 'package:hibuy/widgets/profile_image_container.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({super.key});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String networkImageUrl = '';
  File? newProfileImage;
  @override
  void initState() {
    super.initState();
    doProcess();
  }

  doProcess() {
    nameController.text =
        context.read<SettingBloc>().state.sellerDetails?.name ?? '';
    emailController.text =
        context.read<SettingBloc>().state.sellerDetails?.email ?? '';
    phoneController.text =
        context.read<SettingBloc>().state.sellerDetails?.phone.toString() ?? '';
    addressController.text =
        context.read<SettingBloc>().state.sellerDetails?.address ?? '';
    networkImageUrl =
        "${AppUrl.websiteUrl}/${context.read<SettingBloc>().state.sellerDetails?.profilePicture ?? ''}";
    log("message@@@@@@");
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          // left: context.widthPct(17 / 375),
          // right: context.widthPct(17 / 375),
          top: context.heightPct(21 / 812),
        ),
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            if (state.savingDataStatus == SavingProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: ProfileImageContainer(
                      networkImageUrl: networkImageUrl,
                      imageKey: 'profile_setting',
                      profileImageBytes: state.sellerDetails?.profileImageFile,
                      onImagePicked: (File? pickedImage) {
                        setState(() {
                          newProfileImage = pickedImage;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: context.heightPct(0.015)),
                  ReusableTextField(
                    controller: nameController,
                    hintText: AppStrings.enterhere,
                    labelText: AppStrings.fullname,
                  ),
                  SizedBox(height: context.heightPct(0.015)),
                  ReusableTextField(
                    controller: emailController,
                    hintText: AppStrings.enterhere,
                    labelText: AppStrings.email,
                  ),
                  SizedBox(height: context.heightPct(0.015)),
                  ReusableTextField(
                    controller: phoneController,
                    hintText: AppStrings.enterhere,
                    labelText: AppStrings.phoneNo,
                  ),
                  SizedBox(height: context.heightPct(0.015)),
                  ReusableTextField(
                    controller: addressController,
                    hintText: AppStrings.enterhere,
                    labelText: AppStrings.address,
                  ),
                  SizedBox(height: context.heightPct(0.015)),
                  ReusableButton(
                    text: "Done",
                    onPressed: () {
                      context.read<SettingBloc>().add(
                        UpdateProfile(
                          profileImage: newProfileImage,

                          sellerDetails: SellerDetails(
                            name: nameController.text,
                            email: emailController.text,
                            phone: int.parse(phoneController.text),
                            address: addressController.text,
                            profilePicture: networkImageUrl,
                            referralLink:
                                state.sellerDetails?.referralLink ?? '',
                            encodedUserId:
                                state.sellerDetails?.encodedUserId ?? '',
                          ),
                        ),
                      );
                      // Navigator.pushNamed(context, RoutesName.BusinessVerification);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
