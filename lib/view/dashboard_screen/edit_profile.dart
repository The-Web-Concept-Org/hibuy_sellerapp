import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/id_image.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.editprofile,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          top: context.heightPct(14 / 812),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: context.heightPct(90 / 812),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    border: Border.all(color: AppColors.stroke, width: 0.3),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.primaryColor, AppColors.yellow],
                    ),
                  ),
                ),
                Positioned(
                  top: context.heightPct(59 / 812),
                  left: context.widthPct(133 / 375),
                  child: Container(
                    width: context.widthPct(74 / 375),
                    height: context.heightPct(74 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.stroke, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: ReusableImageContainer(
                        widthFactor: 0.32,
                        heightFactor: 0.36,
                        placeholderSvg: ImageAssets.profileimage,
                        imageKey: 'profile',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(15 / 812)),
            ReusableTextField(
              hintText: AppStrings.enterhere,
              labelText: AppStrings.storename,
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            Row(
              children: [
                Expanded(
                  child: ReusableTextField(
                    hintText: AppStrings.enterhere,
                    labelText: AppStrings.tags,
                  ),
                ),

                Container(
                  height: 46,
                  width: 43, // fixed width
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    border: Border.all(color: AppColors.stroke, width: 1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Icon(Icons.add, color: AppColors.white),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            Text(AppStrings.banner, style: AppTextStyles.bodyRegular(context)),
            Text(AppStrings.max2mb, style: AppTextStyles.searchtext(context)),
            SizedBox(height: context.heightPct(5 / 812)),

            ReusableImageContainer(
              widthFactor: 0.9, // 90% of screen width
              heightFactor: 0.21,
              placeholderSvg: ' ImageAssets.profileimage',
              imageKey: 'profile image', // 25% of screen height
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            Text(AppStrings.post, style: AppTextStyles.bodyRegular(context)),
            Text(AppStrings.eachpost, style: AppTextStyles.searchtext(context)),
            SizedBox(height: context.heightPct(5 / 812)),
            GridView.builder(
              itemCount: 2,
              shrinkWrap: true, // 👈 important
              physics:
                  const NeverScrollableScrollPhysics(), // 👈 disable inner scroll
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isMobile
                    ? 3
                    : (context.isTablet ? 4 : 6),
                crossAxisSpacing: context.widthPct(20 / 375),
                mainAxisSpacing: context.heightPct(20 / 812),
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: context.widthPct(160 / 375),
                  height: context.heightPct(160 / 812),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      context.widthPct(0.027),
                    ),
                    border: Border.all(
                      color: AppColors.stroke,
                      width: context.widthPct(0.0025),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAssets.profileimage,
                      height: context.heightPct(15 / 812),
                      width: context.widthPct(36 / 375),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: context.heightPct(23 / 812)),
            ReusableButton(
              text: AppStrings.done,
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
