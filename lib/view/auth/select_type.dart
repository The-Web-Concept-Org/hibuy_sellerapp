import 'package:flutter/material.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';

class SelectType extends StatelessWidget {
  const SelectType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.widthPct(0.06), // ~22px padding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Logo
            SizedBox(height: context.heightPct(0.07)),
            Center(
              child: Image.asset(
                ImageAssets.app_logo2,
                height: context.heightPct(0.15),
              ),
            ),

            SizedBox(height: context.heightPct(0.01)),

            /// Welcome Text
            Text(AppStrings.welcometoHiBuyO, style: AppTextStyles.h4(context)),
            SizedBox(height: context.heightPct(0.01)),
            Text(
              AppStrings.selectStoreType,
              style: AppTextStyles.bodyRegular(context),
            ),

            SizedBox(height: context.heightPct(0.009)),
            SizedBox(height: context.heightPct(0.0139)),
            _buildCard(
              context,
              image: ImageAssets.frelancer,
              text: AppStrings.freelancer,
              role: "freelancer",
            ),

            SizedBox(height: context.heightPct(0.02)),

            _buildCard(
              context,
              image: ImageAssets.seller,
              text: AppStrings.seller,
              role: "seller",
            ),
            SizedBox(height: context.heightPct(0.07)),
          ],
        ),
      ),
    );
  }

  /// ✅ Reusable card widget
  Widget _buildCard(
    BuildContext context, {
    required String image,
    required String text,
    required String role,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutesName.signupScreen,
            arguments: role,
          );
        },
        child: Container(
          // height: context.heightPct(231 / 812),
          width: context.widthPct(225 / 375),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(context.widthPct(18 / 375)),
            border: Border.all(
              color: AppColors.gray,
              width: context.widthPct(3 / 375),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: context.heightPct(97.5 / 812),
                width: context.widthPct(97.5 / 375),
              ),
              SizedBox(height: context.heightPct(0.03)),
              Text(text, style: AppTextStyles.h4(context)),
            ],
          ),
        ),
      ),
    );
  }
}
