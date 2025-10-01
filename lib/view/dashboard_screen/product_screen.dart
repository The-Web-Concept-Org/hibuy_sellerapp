import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375), // instead of 17
          right: context.widthPct(17 / 375),
          top: context.heightPct(58 / 812), // instead of 58
        ),
        child: Column(
          children: [
            /// Top Tabs
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
                      AppStrings.allproducts,
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
                      AppStrings.boostedproducts,
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
            SizedBox(height: context.heightPct(20 / 812)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.productdetailscreen);
              },
              child: Container(
                width: double.maxFinite,
                height: context.heightPct(91.92 / 812),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.stroke, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.widthPct(9.82 / 375),
                    vertical: context.heightPct(11.22 / 812),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/dashboard/image 635.png"),
                      SizedBox(width: context.widthPct(7 / 375)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.widthPct(172 / 375),
                            height: context.heightPct(36 / 812),
                            child: Text(
                              'Lorem ipsum dolor sit dolor  ipsum dolor sit ...',
                              style: AppTextStyles.samibold3(context),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              "Category 7",
                              style: AppTextStyles.regular2(context),
                            ),
                          ),
                          SizedBox(height: context.heightPct(4 / 812)),
                          SizedBox(
                            child: Text(
                              "\$930",
                              style: AppTextStyles.samibold3(context),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.more_vert,
                            size: context.widthPct(15 / 375),
                            color: AppColors.black,
                          ),
              
                          SizedBox(height: context.heightPct(6 / 812)),
                          Container(
                            width: context.widthPct(52.62 / 375),
                            height: context.heightPct(16.84 / 812),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Center(
                              child: Text(
                                "boosted",
                                style: AppTextStyles.medium(context),
                              ),
                            ),
                          ),
                          SizedBox(height: context.heightPct(7.72 / 812)),
                          Container(
                            width: context.widthPct(52.62 / 375),
                            height: context.heightPct(16.84 / 812),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Center(
                              child: Text(
                                "active",
                                style: AppTextStyles.medium(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addproductscreen);
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
