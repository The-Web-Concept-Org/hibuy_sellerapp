import 'package:flutter/material.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class PasswordSetting extends StatelessWidget {
  const PasswordSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          // left: context.widthPct(17 / 375),
          // right: context.widthPct(17 / 375),
          top: context.heightPct(21 / 812),
        ),
        child: Column(
          children: [
        
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.currentpassword,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.newpassword,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.phoneNo,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.reenternewpassword,
            ),
            SizedBox(height: context.heightPct(0.015)),
            ReusableButton(
              text: "Done",
              onPressed: () {
                // Navigator.pushNamed(context, RoutesName.BusinessVerification);
              },
            ),
          ],
        ),
      ),
    );
  
  }
}