import 'package:flutter/material.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});

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
        child: Column(
          children: [
            Center(
              child: Container(
                width: context.widthPct(74 / 375),
                height: context.heightPct(74 / 812),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.stroke, width: 1),
                   shape: BoxShape.circle,
                ),
                child: Center(
                  child: ReusableImageContainer(
                    widthFactor: 0.32,
                    heightFactor: 0.36, placeholderSvg: ImageAssets.profileimage,imageKey: 'profile',
                  ),
                ),
              ),
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.fullname,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.email,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.phoneNo,
            ),
            SizedBox(height: context.heightPct(0.015)),
            const ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.address,
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
