import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';

class ReturnorderScreen extends StatelessWidget {
  const ReturnorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
       appBar: const CustomAppBar(
        title: AppStrings.returnorders,
        previousPageTitle: "Back",
      ),
      body:  Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375), 
          right: context.widthPct(17 / 375),
         // top: context.heightPct(58 / 812), 
        ),
        child: Column(
          children: [
            SizedBox(height: context.heightPct(12 / 812)),

            /// Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: context.heightPct(40 / 812),
                    padding: EdgeInsets.fromLTRB(
                      context.widthPct(16 / 375), // left
                      context.heightPct(12 / 812), // top
                      context.widthPct(16 / 375), // right
                      context.heightPct(12 / 812), // bottom
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.stroke, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: context.widthPct(18 / 375),
                          color: AppColors.secondry.withOpacity(0.5),
                        ),
                        SizedBox(width: context.widthPct(8 / 375)),
                        Text(
                          AppStrings.searchproduct,
                          style: AppTextStyles.searchtext(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: context.widthPct(9 / 375)),
                SvgPicture.asset(
                  ImageAssets.searchicon,
                  height: context.heightPct(20 / 812),
                  width: context.widthPct(20 / 375),
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            Stack(
              children: [
                // Main container background
                Container(
                  width: double.maxFinite,
                  height: context.heightPct(128 / 812),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.stroke, width: 1),
                  ),
                ),

                // Top colored header
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: context.heightPct(32 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.widthPct(10 / 375),
                        right: context.widthPct(4 / 375),
                        top: context.heightPct(7 / 812),
                        bottom: context.heightPct(8 / 812),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "3/ TRK-5848184331",
                            style: AppTextStyles.medium(context),
                          ),
                          Container(
                            width: context.widthPct(77 / 375),
                            height: context.heightPct(17 / 812),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.stroke,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "In Progress",
                                style: AppTextStyles.regular(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Name + contact row
                Positioned(
                  top: context.heightPct(43 / 812),
                  left: context.widthPct(10 / 375),
                  right: context.widthPct(10 / 375),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Awais Ansari",
                        style: AppTextStyles.unselect(context),
                      ),
                      Text(
                        "0300 1234567",
                        style: AppTextStyles.regular2(context),
                      ),
                    ],
                  ),
                ),

                // Rider + Date row
                Positioned(
                  top: context.heightPct(62 / 812),
                  left: context.widthPct(10 / 375),
                  right: context.widthPct(10 / 375),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rider Name (Van)",
                        style: AppTextStyles.regular2(context),
                      ),
                      Text(
                        "27 Aug, 2025",
                        style: AppTextStyles.regular2(context),
                      ),
                    ],
                  ),
                ),

                // Price row
                Positioned(
                  top: context.heightPct(78 / 812),
                  left: context.widthPct(10 / 375),
                  right: context.widthPct(10 / 375),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Rs. 120.25",
                        style: AppTextStyles.samibold3(context),
                      ),
                    ],
                  ),
                ),

                // Divider
                Positioned(
                  top: context.heightPct(89 / 812),
                  left: context.widthPct(10 / 375),
                  right: context.widthPct(10 / 375),
                  child: Divider(color: AppColors.stroke),
                ),

                // Delivery Status + Icons
                Positioned(
                  top: context.heightPct(98 / 812),
                  left: context.widthPct(10 / 375),
                  right: context.widthPct(10 / 375),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Status: In Transit",
                        style: AppTextStyles.unselect(context),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.eyes,
                            height: context.heightPct(24 / 812),
                            width: context.widthPct(24 / 375),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: context.widthPct(7 / 375)),
                          SvgPicture.asset(
                            ImageAssets.print,
                            height: context.heightPct(24 / 812),
                            width: context.widthPct(24 / 375),
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    
    );
  }
}