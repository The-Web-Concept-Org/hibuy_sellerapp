import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';

class StatusStepTile extends StatelessWidget {
  final int index;
  final String title;
  
  final bool isSelected;
  final bool isCompleted;
  final bool isLast;
  final VoidCallback? onTap;

  const StatusStepTile({
    required this.index,
    required this.title,
   
    required this.isSelected,
    required this.isCompleted,
    required this.isLast,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                        color: isCompleted
                            ? AppColors.profileborder
                            : AppColors.gray,
                        width: context.widthPct(2 / 375),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: context.widthPct(20 / 375),
                      backgroundColor: AppColors.white,
                      child: SvgPicture.asset(
                        ImageAssets.documents, // 👈 your step icon
                        height: context.heightPct(20 / 812),
                        width: context.widthPct(20 / 375),
                        color: isCompleted
                            ? AppColors.profileborder
                            : AppColors.gray,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  /// ✅ Only show top-right icon when completed
                  if (isCompleted)
                    Positioned(
                      right: -context.widthPct(2 / 375),
                      top: -context.heightPct(2 / 812),
                      child: CircleAvatar(
                        radius: context.widthPct(10 / 375),
                        backgroundColor: AppColors.profileborder,
                        child:SvgPicture.asset(
                          ImageAssets.profile, // ✅ completed step icon
                          height: context.heightPct(10 / 812),
                          width: context.widthPct(10 / 375),
                          fit: BoxFit.contain,
                        ), 
                      ),
                    ),
                ],
              ),

              /// Connector line (if not last step)
              // if (!isLast)
              //   Container(
              //     height: context.heightPct(20 / 812),
              //     width: context.widthPct(2 / 375),
              //     color: AppColors.gray,
              //   ),
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
