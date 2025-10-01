import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/utils/validations.dart';
import 'package:hibuy/services/location_service.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/profile_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class StoreInfoScreen extends StatefulWidget {
  const StoreInfoScreen({super.key});

  @override
  State<StoreInfoScreen> createState() => _StoreInfoScreenState();
}

class _StoreInfoScreenState extends State<StoreInfoScreen> {
  // ✅ Controllers
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeTypeController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinLocationController = TextEditingController();

  // ✅ FormKey
  final _formKey = GlobalKey<FormState>();
  // focus node
  final FocusNode storenameFocus = FocusNode();
  final FocusNode storetypeFocus = FocusNode();
  final FocusNode SelectStoreTypeFocus = FocusNode();
  final FocusNode phoneNoFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode provinceregionFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode zipcodeFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode location_onFocus = FocusNode();

  @override
  void dispose() {
    storeNameController.dispose();
    storeTypeController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    countryController.dispose();
    provinceController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    addressController.dispose();
    pinLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.MyStoreInformation,
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
                  imageKey: "store",
                  sizeFactor: 0.28,
                ),
              ),
              SizedBox(height: context.heightPct(0.03)),

              // ✅ Pass Validators
              ReusableTextField(
                controller: storeNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.storename,
                focusNode: storenameFocus,
                nextFocusNode: SelectStoreTypeFocus,
                validator: (val) => KycValidator.validate("store_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: storeTypeController,
                hintText: AppStrings.select,
                labelText: AppStrings.SelectStoreType,
                trailingIcon: Icons.expand_more,
                focusNode: SelectStoreTypeFocus,
                nextFocusNode: phoneNoFocus,
                //validator: (val) => KycValidator.validate("store_type", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: phoneNoController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.phoneNo,
                keyboardType: TextInputType.phone,
                focusNode: phoneNoFocus,
                nextFocusNode: emailFocus,
                validator: (val) =>
                    KycValidator.validate("store_phone_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: emailController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.email,
                focusNode: emailFocus,
                nextFocusNode: countryFocus,
                validator: (val) => KycValidator.validate("store_email", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: countryController,
                hintText: AppStrings.select,
                labelText: AppStrings.country,
                trailingIcon: Icons.expand_more,
                focusNode: countryFocus,
                nextFocusNode: provinceregionFocus,
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: provinceController,
                hintText: AppStrings.select,
                labelText: AppStrings.provinceregion,
                trailingIcon: Icons.expand_more,
                focusNode: provinceregionFocus,
                nextFocusNode: cityFocus,
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: cityController,
                hintText: AppStrings.select,
                labelText: AppStrings.city,
                trailingIcon: Icons.expand_more,
                focusNode: cityFocus,
                nextFocusNode: zipcodeFocus,
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: zipCodeController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.zipcode,
                keyboardType: TextInputType.phone,
                focusNode: zipcodeFocus,
                nextFocusNode: addressFocus,
                validator: (val) =>
                    KycValidator.validate("store_zip_code", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: addressController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.address,
                focusNode: addressFocus,
                nextFocusNode: location_onFocus,
                validator: (val) => KycValidator.validate("store_address", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: pinLocationController,
                hintText: AppStrings.select,
                labelText: AppStrings.pinlocation,
                trailingIcon: Icons.location_on,
                focusNode: location_onFocus,
                textInputAction: TextInputAction.done,
                validator: (val) =>
                    KycValidator.validate("store_pin_location", val),
                onIconTap: () async {
                  await getCurrentLocation(pinLocationController);
                },
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ BlocConsumer
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.storeStatus == StoreStatus.success) {
                    Navigator.pushNamed(
                      context,
                      RoutesName.DocumentVerification,
                    );
                  } else if (state.storeStatus == StoreStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                  print(
                        "storeProfilePicture: ${state.storeProfilePicture}",
                      );
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.storeStatus == StoreStatus.loading
                        ? "Saving..."
                        : "Done",
                    onPressed: () {
                      

                      // ✅ First Validate Form
                      if (_formKey.currentState!.validate()) {
                        final storeImagePath = context
                            .read<ImagePickerBloc>()
                            .state
                            .images['store'];
                        final File? store = storeImagePath != null
                            ? File(storeImagePath)
                            : null;
                        context.read<AuthBloc>().add(
                          SaveStoreInfoEvent(
                            storeName: storeNameController.text,
                            type: storeTypeController.text,
                            phoneNo: phoneNoController.text,
                            email: emailController.text,
                            country: countryController.text,
                            province: provinceController.text,
                            city: cityController.text,
                            zipCode: zipCodeController.text,
                            address: addressController.text,
                            pinLocation: pinLocationController.text,
                            profilePicture: store, // ✅ File
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
