import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({super.key, this.onProfileTap, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.topPadding + 8, // respect status bar + spacing
        left: context.widthPct(0.05),
        right: context.widthPct(0.05),
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gray, // only bottom border
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ✅ Profile with CircleAvatar + border
          Container(
            width: context.widthPct(37 / 375),
            height: context.heightPct(37 / 812),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2.85),
            ),
            child: const CircleAvatar(
              // backgroundImage: AssetImage("assets/images/profile.png"),
              backgroundColor: Colors.white,
            ),
          ),

          // ✅ Center logo
          Image.asset(ImageAssets.app_logo2, height: 35),

          // ✅ Notification with badge
          GestureDetector(
            onTap: onNotificationTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  ImageAssets.notification,
                  color: AppColors.gray,
                  height: 20,
                ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "4",
                      style: TextStyle(
                        fontSize: context.scaledFont(10),
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
