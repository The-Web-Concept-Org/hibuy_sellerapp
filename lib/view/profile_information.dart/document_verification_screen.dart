import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class DocumentVerificationScreen extends StatefulWidget {
  const DocumentVerificationScreen({super.key});

  @override
  State<DocumentVerificationScreen> createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState
    extends State<DocumentVerificationScreen> {
  // ✅ Controllers
  final TextEditingController countryController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // ✅ Form Key
  final _formKey = GlobalKey<FormState>();
  // focus node
  final FocusNode countryFocus = FocusNode();
  final FocusNode provinceFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();

  @override
  void dispose() {
    countryController.dispose();
    provinceController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.documentVerification,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.widthPct(0.043), // ~16px
        ),
        child: Form(
          key: _formKey, // ✅ Wrap with Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.heightPct(0.018)),
              Text(
                AppStrings.shophome,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'profileimage',
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.shopvideo,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'profile',
              ),

              SizedBox(height: context.heightPct(0.02)),

              // ✅ Fields with validation
              ReusableTextField(
                controller: countryController,
                hintText: AppStrings.select,
                labelText: AppStrings.country,
                trailingIcon: Icons.expand_more,
                focusNode: countryFocus,
                nextFocusNode: provinceFocus,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please select a country";
                  }
                  return null;
                },
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: provinceController,
                hintText: AppStrings.select,
                labelText: AppStrings.provinceregion,
                trailingIcon: Icons.expand_more,
                focusNode: provinceFocus,
                nextFocusNode: cityFocus,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please select a province/region";
                  }
                  return null;
                },
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: cityController,
                hintText: AppStrings.select,
                labelText: AppStrings.city,
                trailingIcon: Icons.expand_more,
                focusNode: cityFocus,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please select a city";
                  }
                  return null;
                },
              ),

              SizedBox(height: context.heightPct(0.03)),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.documentsStatus == DocumentsStatus.success) {
                    Navigator.pushNamed(
                      context,
                      RoutesName.businessVerification,
                    );
                  } else if (state.documentsStatus == DocumentsStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                  print("documentsHomeBill: ${state.documentsHomeBill}");
                  print("documentsShopVideo: ${state.documentsShopVideo}");
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.documentsStatus == DocumentsStatus.loading
                        ? "Saving..."
                        : "Done",
                    onPressed: () {
                      // ✅ Validate before submitting
                      if (_formKey.currentState!.validate()) {
                        final imageState = context
                            .read<ImagePickerBloc>()
                            .state;

                        final profileImagePath =
                            imageState.images['profileimage'];
                        final frontImagePath = imageState.images['profile'];

                        final File? profileImage = profileImagePath != null
                            ? File(profileImagePath)
                            : null;

                        final File? frontImage = frontImagePath != null
                            ? File(frontImagePath)
                            : null;

                        context.read<AuthBloc>().add(
                          SaveDocumentsInfoEvent(
                            country: countryController.text,
                            province: provinceController.text,
                            city: cityController.text,
                            homeBill: profileImage,
                            shopVideo: frontImage,
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
