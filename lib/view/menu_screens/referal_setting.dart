import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';
import 'package:hibuy/widgets/auth/button.dart';

class ReferalSetting extends StatelessWidget {
  const ReferalSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: context.heightPct(16 / 812),
          ),
          child: Column(
            children: [
              /// Top Banner
              Container(
                width: double.infinity,
                height: context.heightPct(108 / 812),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.refealBg),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Reffer Freinds. \nGet 100 Credits",
                      style: AppTextStyles.bold2(context),
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.heightPct(12 / 812)),

              /// Card Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(4.48),
                ),
                padding: EdgeInsets.all(context.widthPct(20 / 375)),
                child: Column(
                  children: [
                    /// Referral ID Row
                    _buildInfoRow(
                      context,
                      title: AppStrings.referralid,
                      value:
                          context
                              .read<SettingBloc>()
                              .state
                              .sellerDetails
                              ?.encodedUserId ??
                          '',
                      icon: ImageAssets.copyicon,
                    ),

                    SizedBox(height: context.heightPct(17 / 812)),

                    /// Referral Link Row
                    _buildInfoRow(
                      context,
                      title: AppStrings.referrallink,
                      value:
                          context
                              .read<SettingBloc>()
                              .state
                              .sellerDetails
                              ?.referralLink ??
                          '',
                      icon: ImageAssets.copyicon,
                    ),

                    SizedBox(height: context.heightPct(24 / 812)),

                    /// Invite Button
                    Container(
                      width: double.maxFinite,
                      height: context.heightPct(44.75 / 812),
                      color: AppColors.primaryColor,
                      child: Center(
                        child: Text(
                          AppStrings.invitefriends,
                          style: AppTextStyles.medium2(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable row for referral ID / link
  Widget _buildInfoRow(
    BuildContext context, {
    required String title,
    required String value,
    required String icon,
  }) {
    return Container(
      width: double.infinity,
      height: context.heightPct(44.75 / 812),
      decoration: BoxDecoration(color: AppColors.white),
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(14 / 375)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.referal(context)),
          Row(
            children: [
              Text(
                value.length > 10 ? '${value.substring(0, 15)}...' : value,
                style: AppTextStyles.referal(context),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: context.widthPct(5 / 375)),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                child: SvgPicture.asset(icon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
