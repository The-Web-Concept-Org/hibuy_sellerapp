import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class StatusStepTile extends StatelessWidget {
  final int index;
  final String title;
  final String status;
  final VoidCallback? onTap;

  const StatusStepTile({
    required this.index,
    required this.title,
    required this.status,
    this.onTap,
    super.key,
  });

  /// ✅ Get color based on status
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'reject':
        return AppColors.profileborder; // green or success color
      case 'approve':
        return AppColors.primaryColor; // rejected
      case 'pending':
      default:
        return AppColors.gray; // default gray
    }
  }

  /// ✅ Get top-right icon based on status
  String _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'approve':
        return ImageAssets.statusapprove; // e.g. ✅ approved icon
      case 'reject':
        return ImageAssets.review; // e.g. ❌ rejected icon
      case 'pending':
      default:
        return ImageAssets.profile; // e.g. ⏳ pending/default
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    final statusIcon = _getStatusIcon();

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              /// Circle with border + main icon
              Container(
                padding: EdgeInsets.all(context.widthPct(4 / 375)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color,
                    width: context.widthPct(2 / 375),
                  ),
                ),
                child: CircleAvatar(
                  radius: context.widthPct(20 / 375),
                  backgroundColor: AppColors.white,
                  child: SvgPicture.asset(
                    ImageAssets.documents,
                    height: context.heightPct(20 / 812),
                    width: context.widthPct(20 / 375),
                    color: color,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// ✅ Top-right icon
              Positioned(
                right: -context.widthPct(2 / 375),
                top: -context.heightPct(2 / 812),
                child: CircleAvatar(
                  radius: context.widthPct(10 / 375),
                  backgroundColor: color,
                  child: SvgPicture.asset(
                    statusIcon,
                    height: context.heightPct(10 / 812),
                    width: context.widthPct(10 / 375),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: context.widthPct(12 / 375)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.unselect(context)),
              SizedBox(height: context.heightPct(16 / 812)),
            ],
          ),
        ],
      ),
    );
  }
}
