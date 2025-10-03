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
import 'package:hibuy/services/location_service.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/profile_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class BusinessVerificationScreen extends StatefulWidget {
  const BusinessVerificationScreen({super.key});

  @override
  State<BusinessVerificationScreen> createState() =>
      _BusinessVerificationScreenState();
}

class _BusinessVerificationScreenState
    extends State<BusinessVerificationScreen> {
  // ✅ Controllers
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController registrationNoController =
      TextEditingController();
  final TextEditingController taxNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController pinLocationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // focus node
  final FocusNode businessNameFocus = FocusNode();
  final FocusNode registrationNoFocus = FocusNode();
  final FocusNode taxNoFocus = FocusNode();
  final FocusNode provinceregionFocus = FocusNode();
  final FocusNode pinLocationFocus = FocusNode();
  final FocusNode phoneNoFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode ownerfocus = FocusNode();

  @override
  void dispose() {
    businessNameController.dispose();
    registrationNoController.dispose();
    taxNoController.dispose();
    addressController.dispose();
    phoneNoController.dispose();
    pinLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.businessVerification,
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
              const Center(
                child: ReusableCircleImage(
                  placeholderSvg: ImageAssets.profileimage,
                  imageKey: "business",
                  sizeFactor: 0.28,
                ),
              ),
              SizedBox(height: context.heightPct(0.03)),

              // ✅ VALIDATED FIELDS
              ReusableTextField(
                controller: businessNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.businessname,
                focusNode: businessNameFocus,
                nextFocusNode: ownerfocus,
                validator: (val) =>
                    KycValidator.validate("business_business_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),
              ReusableTextField(
                controller: ownerNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.ownerName,
                focusNode: ownerfocus,
                nextFocusNode: registrationNoFocus,
                validator: (val) =>
                    KycValidator.validate("business_owner_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),
              ReusableTextField(
                controller: registrationNoController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.registrationnumber,
                keyboardType: TextInputType.phone,
                focusNode: registrationNoFocus,
                nextFocusNode: phoneNoFocus,
                validator: (val) =>
                    KycValidator.validate("business_reg_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: phoneNoController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.phoneNo,
                keyboardType: TextInputType.phone,
                focusNode: phoneNoFocus,
                nextFocusNode: addressFocus,
                validator: (val) =>
                    KycValidator.validate("business_phone_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: addressController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.address,
                focusNode: addressFocus,
                nextFocusNode: taxNoFocus,
                validator: (val) =>
                    KycValidator.validate("business_address", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: taxNoController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.taxnumber,
                keyboardType: TextInputType.phone,
                focusNode: taxNoFocus,
                nextFocusNode: pinLocationFocus,
                validator: (val) =>
                    KycValidator.validate("business_tax_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: pinLocationController,
                hintText: AppStrings.select,
                labelText: AppStrings.pinlocation,
                trailingIcon: Icons.location_on,
                focusNode: pinLocationFocus,
                textInputAction: TextInputAction.done,
                validator: (val) =>
                    KycValidator.validate("business_pin_location", val),
                onIconTap: () async {
                  await getCurrentLocation(pinLocationController);
                },
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.letterhead,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'leter',
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(AppStrings.stamp, style: AppTextStyles.bodyRegular(context)),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'stamp',
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ BlocConsumer for Save Button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.businessStatus == BusinessStatus.success) {
                    Navigator.pushNamed(
                      context,
                      RoutesName.bankAccountVerification,
                    );
                  } else if (state.businessStatus == BusinessStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                  print(
                    "businessPersonalProfile: ${state.businessPersonalProfile}",
                  );
                  print("businessLetterHead: ${state.businessLetterHead}");
                  print("businessStamp: ${state.businessStamp}");
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.businessStatus == BusinessStatus.loading
                        ? "Saving..."
                        : "Done",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final imageState = context
                            .read<ImagePickerBloc>()
                            .state;

                        final StampImagePath = imageState.images['stamp'];
                        final LeterImagePath = imageState.images['leter'];
                        final BusinessProfilePath =
                            imageState.images['business'];

                        final File? StampImage = StampImagePath != null
                            ? File(StampImagePath)
                            : null;

                        final File? LeterImage = LeterImagePath != null
                            ? File(LeterImagePath)
                            : null;

                        final File? BusinessImage = BusinessProfilePath != null
                            ? File(BusinessProfilePath)
                            : null;

                        context.read<AuthBloc>().add(
                          SaveBusinessInfoEvent(
                            businessName: businessNameController.text,
                            ownerName: ownerNameController.text,
                            phoneNo: phoneNoController.text,
                            regNo: registrationNoController.text,
                            taxNo: taxNoController.text,
                            address: addressController.text,
                            pinLocation: pinLocationController.text,
                            letterHead: LeterImage,
                            stamp: StampImage,
                            businessPersonalProfile: BusinessImage,
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
