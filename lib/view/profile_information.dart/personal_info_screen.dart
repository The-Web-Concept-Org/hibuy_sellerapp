import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/res/utils/validations.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/profile_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  // ✅ Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // ✅ FormKey
  final _formKey = GlobalKey<FormState>();
  // focus
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode cnicFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  bool _hasNavigated = false; // Flag to prevent duplicate navigation

  @override
  void initState() {
    super.initState();
    // Restore data from AuthBloc
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState.personalFullName != null) {
        _fullNameController.text = authState.personalFullName!;
      }
      if (authState.personalAddress != null) {
        _addressController.text = authState.personalAddress!;
      }
      if (authState.personalCnic != null) {
        _cnicController.text = authState.personalCnic!;
      }
      if (authState.personalPhoneNo != null) {
        _phoneController.text = authState.personalPhoneNo!;
      }
      if (authState.personalEmail != null) {
        _emailController.text = authState.personalEmail!;
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cnicController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get AuthState to access network URLs
    final authState = context.watch<AuthBloc>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.personalInformation,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.043)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.heightPct(0.025)),

              // ✅ Profile Image
              Center(
                child: ReusableCircleImage(
                  placeholderSvg: ImageAssets.profileimage,
                  imageKey: 'personal',
                  networkImageUrl:
                      authState.personalProfilePictureUrl, // ✅ Network URL
                ),
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ Text Fields with validation
              ReusableTextField(
                controller: _fullNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.fullname,
                focusNode: fullNameFocus,
                nextFocusNode: addressFocus,
                validator: (val) =>
                    KycValidator.validate("personal_full_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _addressController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.address,
                focusNode: addressFocus,
                nextFocusNode: phoneFocus,
                validator: (val) =>
                    KycValidator.validate("personal_address", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _phoneController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.phoneNo,
                keyboardType: TextInputType.phone,
                focusNode: phoneFocus,
                nextFocusNode: emailFocus,
                validator: (val) =>
                    KycValidator.validate("personal_phone_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _emailController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.email,
                focusNode: emailFocus,
                nextFocusNode: cnicFocus,
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    KycValidator.validate("personal_email", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _cnicController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.cnic,
                keyboardType: TextInputType.phone,
                focusNode: cnicFocus,
                textInputAction: TextInputAction.done,
                validator: (val) => KycValidator.validate("personal_cnic", val),
              ),

              SizedBox(height: context.heightPct(0.015)),
              Text(
                AppStrings.cnicFrontImage,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              ReusableImageContainer(
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'cnicFrontImage',
                networkImageUrl:
                    authState.personalFrontImageUrl, // ✅ Network URL
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.cnicBackImage,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              ReusableImageContainer(
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'cnicBackImage',
                networkImageUrl:
                    authState.personalBackImageUrl, // ✅ Network URL
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ BlocConsumer for Save Button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.personalStatus == PersonalStatus.success &&
                      !_hasNavigated) {
                    _hasNavigated = true;
                    Navigator.pushNamed(context, RoutesName.myStoreInformation);
                  } else if (state.personalStatus == PersonalStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                  print(
                    "personalProfilePicture (Bloc state): ${state.personalProfilePicture}",
                  );
                  print(
                    "personalFrontImage (Bloc state): ${state.personalFrontImage}",
                  );
                  print(
                    "personalBackImage (Bloc state): ${state.personalBackImage}",
                  );
                  print("full name (Bloc state): ${state.personalFullName}");
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.personalStatus == PersonalStatus.loading
                        ? "Saving..."
                        : "Done",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _hasNavigated =
                            false; // Reset flag for new save attempt
                        final imageState = context
                            .read<ImagePickerBloc>()
                            .state;

                        final profileImagePath = imageState.images['personal'];
                        final frontImagePath =
                            imageState.images['cnicFrontImage'];
                        final backImagePath =
                            imageState.images['cnicBackImage'];

                        final File? profileImage = profileImagePath != null
                            ? File(profileImagePath)
                            : null;
                        final File? frontImage = frontImagePath != null
                            ? File(frontImagePath)
                            : null;
                        final File? backImage = backImagePath != null
                            ? File(backImagePath)
                            : null;

                        // ✅ Debugging console logs
                        if (profileImage != null) {
                          print(
                            "✅ Profile image successfully converted to File: ${profileImage.path}",
                          );
                        }
                        if (frontImage != null) {
                          print(
                            "✅ CNIC Front image successfully converted to File: ${frontImage.path}",
                          );
                        }
                        if (backImage != null) {
                          print(
                            "✅ CNIC Back image successfully converted to File: ${backImage.path}",
                          );
                        }

                        context.read<AuthBloc>().add(
                          SavePersonalInfoEvent(
                            fullName: _fullNameController.text,
                            address: _addressController.text,
                            cnic: _cnicController.text,
                            phoneNo: _phoneController.text,
                            email: _emailController.text,
                            profilePicture: profileImage, // ✅ File
                            frontImage: frontImage, // ✅ File
                            backImage: backImage, // ✅ File
                          ),
                        );
                      }
                    },
                  );
                },
              ),

              SizedBox(height: context.heightPct(0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
