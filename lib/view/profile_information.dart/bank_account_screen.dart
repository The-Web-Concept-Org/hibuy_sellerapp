import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'package:hibuy/res/utils/validations.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  // ✅ Controllers
  final SingleSelectController<String> _accountTypeController = SingleSelectController<String>(null);
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchCodeController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _branchPhoneController = TextEditingController();
  final TextEditingController _accountTitleController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _ibanNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // focus node
  final FocusNode accountTypeFocus = FocusNode();
  final FocusNode bankNameFocus = FocusNode();
  final FocusNode branchCodeFocus = FocusNode();
  final FocusNode branchNameFocus = FocusNode();
  final FocusNode branchPhoneFocus = FocusNode();
  final FocusNode accountTitleFocus = FocusNode();
  final FocusNode accountNoFocus = FocusNode();
  final FocusNode ibanNoFocus = FocusNode();

  @override
  void dispose() {
    _accountTypeController.dispose();
    _bankNameController.dispose();
    _branchCodeController.dispose();
    _branchNameController.dispose();
    _branchPhoneController.dispose();
    _accountTitleController.dispose();
    _accountNoController.dispose();
    _ibanNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.bankAccountVerification,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.043)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.heightPct(0.018)),

              // Top info card
              Container(
                width: double.maxFinite,
                height: context.heightPct(0.12),
                padding: EdgeInsets.all(context.widthPct(0.026)),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(context.widthPct(0.04)),
                  border: Border.all(
                    width: 2,
                    color: AppColors.profileborder.withOpacity(0.25),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageAssets.kycstatus,
                      height: context.heightPct(60 / 812),
                      width: context.widthPct(60 / 375),
                    ),
                    SizedBox(width: context.widthPct(0.04)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.reason,
                            style: AppTextStyles.samibold2(context),
                          ),
                          SizedBox(height: context.heightPct(0.005)),
                          Text(
                            AppStrings.reasontext,
                            style: AppTextStyles.greytext2(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ TextFields with validators
               Text(
                AppStrings.accounttype,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.007)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
                height: context.heightPct(0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(0.043),
                ),
                child: CustomDropdown<String>(
                  hintText: 'Select ',
                  closedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    hintStyle: AppTextStyles.normal(context),
                  ),
                  items: const ['savings', 'current'],
                   controller: _accountTypeController,
                  onChanged: (value) async {
                    print('Selected: $value');
                  },
                ),
              ),

              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _bankNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.bankname,
                focusNode: bankNameFocus,
                nextFocusNode: branchCodeFocus,
                validator: (val) => KycValidator.validate("bank_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _branchCodeController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.branchcode,
                keyboardType: TextInputType.phone,
                focusNode: branchCodeFocus,
                nextFocusNode: branchNameFocus,
                validator: (val) => KycValidator.validate("branch_code", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _branchNameController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.branchname,
                focusNode: branchNameFocus,
                nextFocusNode: branchPhoneFocus,
                validator: (val) => KycValidator.validate("branch_name", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _branchPhoneController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.branchphone,
                keyboardType: TextInputType.phone,
                focusNode: branchPhoneFocus,
                nextFocusNode: accountTitleFocus,
                validator: (val) =>
                    KycValidator.validate("bank_branch_phone", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _accountTitleController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.accounttitle,
                focusNode: accountTitleFocus,
                nextFocusNode: accountNoFocus,
                validator: (val) =>
                    KycValidator.validate("bank_account_title", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _accountNoController,
                hintText: AppStrings.enterhere,
                labelText: "Account Number",
                focusNode: accountNoFocus,
                nextFocusNode: ibanNoFocus,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    KycValidator.validate("bank_account_no", val),
              ),
              SizedBox(height: context.heightPct(0.015)),

              ReusableTextField(
                controller: _ibanNoController,
                hintText: AppStrings.enterhere,
                labelText: "IBAN Number",
                focusNode: ibanNoFocus,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                validator: (val) => KycValidator.validate("bank_iban_no", val),
              ),
              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.canceledcheque,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'cheque',
              ),

              SizedBox(height: context.heightPct(0.02)),
              Text(
                AppStrings.verificationletter,
                style: AppTextStyles.bodyRegular(context),
              ),
              SizedBox(height: context.heightPct(0.012)),
              const ReusableImageContainer(
                widthFactor: 0.9,
                heightFactor: 0.25,
                placeholderSvg: ImageAssets.profileimage,
                imageKey: 'verification',
              ),

              SizedBox(height: context.heightPct(0.03)),

              // ✅ BlocConsumer for Save Button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.authStatus == AuthStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Submitted Successfully",
                        ),
                      ),
                    );
                    Navigator.pushNamed(context, RoutesName.bottomnabBar);
                  } else if (state.authStatus == AuthStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.authStatus == AuthStatus.loading
                        ? "Submitting..."
                        : "Done",
                    onPressed: () {
                      print(
                        "personalProfilePicture: ${state.personalProfilePicture}",
                      );
                      print("personalFrontImage: ${state.personalFrontImage}");
                      print("personalBackImage: ${state.personalBackImage}");
                      print("bankCanceledCheque: ${state.bankCanceledCheque}");
                      print(
                        "bankCanceledCheque: ${state.bankVerificationLetter}",
                      );
                      final imageState = context.read<ImagePickerBloc>().state;
                      // if (_formKey.currentState!.validate()) {
                      final chequeImagePath = imageState.images['cheque'];
                      final verificationImagePath =
                          imageState.images['business'];

                      final File? chequeImage = chequeImagePath != null
                          ? File(chequeImagePath)
                          : null;

                      final File? verificationImage =
                          verificationImagePath != null
                          ? File(verificationImagePath)
                          : null;
                      context.read<AuthBloc>().add(
                        SubmitAllFormsEvent(
                          accountType: _accountTypeController.toString(),
                          bankName: _bankNameController.text,
                          branchCode: _branchCodeController.text,
                          branchName: _branchNameController.text,
                          branchPhone: _branchPhoneController.text,
                          accountTitle: _accountTitleController.text,
                          accountNo: _accountNoController.text,
                          ibanNo: _ibanNoController.text,
                          canceledCheque: chequeImage,
                          verificationLetter: verificationImage,
                        ),
                      );
                      // }
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
