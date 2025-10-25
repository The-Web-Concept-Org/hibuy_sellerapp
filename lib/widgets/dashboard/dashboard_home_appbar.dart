import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';

class DashboardHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const DashboardHomeAppBar({
    super.key,
    this.onProfileTap,
    this.onNotificationTap,
  });

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
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return Container(
                width: context.widthPct(37 / 375),
                height: context.heightPct(37 / 812),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2.85,
                  ),
                ),
                child: ClipOval(child: _buildProfileImage(state)),
              );
            },
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

  Widget _buildProfileImage(SettingState state) {
    // Priority 1: If we have Uint8List from memory (stored in Hive), show it
    if (state.sellerDetails?.profileImageFile != null &&
        state.sellerDetails!.profileImageFile!.isNotEmpty) {
      return Image.memory(
        state.sellerDetails!.profileImageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Priority 2: If network URL exists, show network image
    if (state.sellerDetails?.profilePicture != null &&
        state.sellerDetails!.profilePicture!.isNotEmpty) {
      return Image.network(
        "${AppUrl.websiteUrl}/${state.sellerDetails!.profilePicture}",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white,
            child: const Icon(Icons.person, color: Colors.grey, size: 20),
          );
        },
      );
    }

    // Show placeholder if no image
    return Container(
      color: Colors.white,
      child: const Icon(Icons.person, color: Colors.grey, size: 20),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
