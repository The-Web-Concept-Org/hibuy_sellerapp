import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({super.key});

  @override
  State<PasswordSetting> createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        child: BlocConsumer<SettingBloc, SettingState>(
          listener: (context, state) {
            if (state.updatePasswordStatus == UpdatePasswordStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password updated successfully')),
              );
            }
          },
          builder: (context, state) {
            if (state.updatePasswordStatus == UpdatePasswordStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return Column(
              children: [
                ReusableTextField(
                  controller: currentPasswordController,
                  hintText: AppStrings.enterhere,
                  labelText: AppStrings.currentpassword,
                ),
                SizedBox(height: context.heightPct(0.015)),
                ReusableTextField(
                  controller: newPasswordController,
                  hintText: AppStrings.enterhere,
                  labelText: AppStrings.newpassword,
                ),
                // SizedBox(height: context.heightPct(0.015)),
                //  ReusableTextField(
                //   controller: confirmPasswordController,
                //   hintText: AppStrings.enterhere,
                //   labelText: AppStrings.phoneNo,
                // ),
                // SizedBox(height: context.heightPct(0.015)),
                ReusableTextField(
                  controller: confirmPasswordController,
                  hintText: AppStrings.enterhere,
                  labelText: AppStrings.reenternewpassword,
                ),
                SizedBox(height: context.heightPct(0.015)),
                ReusableButton(
                  text: "Done",
                  onPressed: () {
                    context.read<SettingBloc>().add(
                      UpdatePassword(
                        oldpassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        reenterNewPassword: confirmPasswordController.text,
                      ),
                    );
                    // Navigator.pushNamed(context, RoutesName.BusinessVerification);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
