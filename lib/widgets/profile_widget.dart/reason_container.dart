import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

reasonContainer({required BuildContext context, required String reason}) {
  return Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.reason, style: AppTextStyles.samibold2(context)),
              SizedBox(height: context.heightPct(0.005)),
              Text(reason, style: AppTextStyles.greytext2(context)),
            ],
          ),
        ),
      ],
    ),
  );
}
