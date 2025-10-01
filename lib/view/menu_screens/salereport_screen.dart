import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class SalereportScreen extends StatelessWidget {
  const SalereportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.salereport,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          // top: context.heightPct(58 / 812),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.heightPct(12 / 812)),
            ReusableTextField(
              hintText: AppStrings.select,
              labelText: AppStrings.orderStatus,
              trailingIcon: Icons.expand_more,
            ),
            SizedBox(height: context.heightPct(12 / 812)),

            // ✅ Row with two textfields
            Row(
              children: [
                Expanded(
                  child: ReusableTextField(
                    hintText: AppStrings.date,
                    labelText: AppStrings.from,
                  ),
                ),
                SizedBox(width: context.widthPct(13 / 375)),
                Expanded(
                  child: ReusableTextField(
                    hintText: AppStrings.date,
                    labelText: AppStrings.to,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            ReusableButton(
              text: AppStrings.applyfilters,
              onPressed: () {
                // Navigator.pushNamed(context, RoutesName.BusinessVerification);
              },
            ),
            SizedBox(height: context.heightPct(15 / 812)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.stroke, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(10 / 375),
                        vertical: context.heightPct(9 / 812),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.totalorders,
                            style: AppTextStyles.cardtext(context),
                          ),
                          SizedBox(height: context.heightPct(4 / 812)),
                          Text("100", style: AppTextStyles.linktext(context)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.stroke, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(10 / 375),
                        vertical: context.heightPct(9 / 812),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.totalamount,
                            style: AppTextStyles.cardtext(context),
                          ),
                          SizedBox(height: context.heightPct(4 / 812)),
                          Text(
                            "Rs. 0000 | Rs. 0000",
                            style: AppTextStyles.linktext(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(16 / 812)),
            SizedBox(
              child: Text(
                AppStrings.orderslist,
                textAlign: TextAlign.start,
                style: AppTextStyles.bold4(context),
              ),
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: context.widthPct(160 / 375), // instead of 160
                  height: context.heightPct(22 / 812), // instead of 22
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.stroke, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.allorders,
                      style: AppTextStyles.allproducts(context),
                    ),
                  ),
                ),
                Container(
                  width: context.widthPct(160 / 375),
                  height: context.heightPct(22 / 812),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.stroke, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.wholesaleorders,
                      style: AppTextStyles.boostedproducts(context),
                    ),
                  ),
                ),
              ],
            ),

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
