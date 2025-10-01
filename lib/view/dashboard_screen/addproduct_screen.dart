import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class AddproductScreen extends StatelessWidget {
  const AddproductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.addproduct,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          top: context.heightPct(12 / 812),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.uploadproductimages,
                style: AppTextStyles.medium3(context),
              ),
              SizedBox(height: context.heightPct(7 / 812)),

              // ✅ RichText with highlighted span
              RichText(
                text: TextSpan(
                  style: AppTextStyles.regular4(context),
                  children: [
                    TextSpan(text: AppStrings.note),
                    TextSpan(
                      text: AppStrings.spantext,
                      style: AppTextStyles.regular(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.heightPct(10 / 812)),

              // ✅ GridView properly inside scroll (shrinkWrap + physics)
              GridView.builder(
                itemCount: 5,
                shrinkWrap: true, // 👈 important
                physics:
                    const NeverScrollableScrollPhysics(), // 👈 disable inner scroll
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.isMobile
                      ? 3
                      : (context.isTablet ? 4 : 6),
                  crossAxisSpacing: context.widthPct(20 / 375),
                  mainAxisSpacing: context.heightPct(20 / 812),
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: context.widthPct(100 / 375),
                    height: context.heightPct(100 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        context.widthPct(0.027),
                      ),
                      border: Border.all(
                        color: AppColors.stroke,
                        width: context.widthPct(0.0025),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ImageAssets.profileimage,
                        height: context.heightPct(15 / 812),
                        width: context.widthPct(36 / 375),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: context.heightPct(25 / 812)),

              // ✅ Custom text fields
              ReusableTextField(
                hintText: AppStrings.enterhere,
                labelText: AppStrings.title,
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              ReusableTextField(
                hintText: AppStrings.enterhere,
                labelText: AppStrings.description,
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              ReusableTextField(
                hintText: AppStrings.enterhere,
                labelText: AppStrings.brand,
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              ReusableTextField(
                hintText: AppStrings.select,
                labelText: AppStrings.category,
                trailingIcon: Icons.expand_more,
              ),
              SizedBox(height: context.heightPct(12 / 812)),

              // ✅ Row with two textfields
              Row(
                children: [
                  Expanded(
                    child: ReusableTextField(
                      hintText: AppStrings.enterhere,
                      labelText: AppStrings.purchaseprice,
                    ),
                  ),
                  SizedBox(width: context.widthPct(13 / 375)),
                  Expanded(
                    child: ReusableTextField(
                      hintText: AppStrings.enterhere,
                      labelText: AppStrings.productprice,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.heightPct(12 / 812)),

              // ✅ Row with two textfields
              Row(
                children: [
                  Expanded(
                    child: ReusableTextField(
                      hintText: AppStrings.enterhere,
                      labelText: AppStrings.discount,
                    ),
                  ),
                  SizedBox(width: context.widthPct(13 / 375)),
                  Expanded(
                    child: ReusableTextField(
                      hintText: AppStrings.enterhere,
                      labelText: AppStrings.discountedprice,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              Container(
                width: double.maxFinite,
                height: context.heightPct(288 / 812),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AppColors.stroke,
                    width: context.widthPct(0.0025),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: context.widthPct(13 / 375),
                    right: context.widthPct(13 / 375),
                    top: context.heightPct(7 / 812),
                    bottom: context.heightPct(15 / 812),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          AppStrings.variants,
                          style: AppTextStyles.bold4(context),
                        ),
                      ),
                      SizedBox(height: context.heightPct(8 / 812)),
                      Container(
                        width: double.maxFinite,
                        height: context.heightPct(46 / 812),

                        decoration: BoxDecoration(
                          color: AppColors.stroke.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.stroke,
                            width: context.widthPct(0.0025),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.addoption,
                            style: AppTextStyles.normal(context),
                          ),
                        ),
                      ),
                      SizedBox(height: context.heightPct(10 / 812)),
                      Container(
                        width: double.maxFinite,
                        height: context.heightPct(85 / 812),

                        decoration: BoxDecoration(
                          color: AppColors.stroke.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.stroke,
                            width: context.widthPct(0.0025),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: context.widthPct(16 / 375),
                            right: context.widthPct(16 / 375),
                            top: context.heightPct(12 / 812),
                            //bottom: context.heightPct(19 / 812),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.color,
                                    style: AppTextStyles.bold4(context),
                                  ),
                                  SvgPicture.asset(
                                    ImageAssets.edit,
                                    height: context.heightPct(20 / 812),
                                    width: context.widthPct(20 / 375),
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                               SizedBox(height: context.heightPct(5/ 812)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: context.widthPct(
                                          100 / 375,
                                        ), // fix width instead of double.maxFinite
                                        child: Container(
                                          height: context.heightPct(33 / 812),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: AppColors.stroke,
                                              width: context.widthPct(0.0025),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppStrings.blue,
                                              style: AppTextStyles.bodyRegular(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.widthPct(10 / 375),
                                      ),
                                      SizedBox(
                                        width: context.widthPct(
                                          100 / 375,
                                        ), // fix width
                                        child: Container(
                                          height: context.heightPct(33 / 812),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: AppColors.stroke,
                                              width: context.widthPct(0.0025),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppStrings.green,
                                              style: AppTextStyles.bodyRegular(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ✅ Icon on the right
                                  SvgPicture.asset(
                                    ImageAssets.delete,
                                    height: context.heightPct(20 / 812),
                                    width: context.widthPct(20 / 375),
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                        SizedBox(height: context.heightPct(13 / 812)),
                      Container(
                        width: double.maxFinite,
                        height: context.heightPct(85 / 812),

                        decoration: BoxDecoration(
                          color: AppColors.stroke.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.stroke,
                            width: context.widthPct(0.0025),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: context.widthPct(16 / 375),
                            right: context.widthPct(16 / 375),
                            top: context.heightPct(12 / 812),
                            //bottom: context.heightPct(19 / 812),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.size,
                                    style: AppTextStyles.bold4(context),
                                  ),
                                  SvgPicture.asset(
                                    ImageAssets.edit,
                                    height: context.heightPct(20 / 812),
                                    width: context.widthPct(20 / 375),
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                               SizedBox(height: context.heightPct(5/ 812)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: context.widthPct(
                                          100 / 375,
                                        ), // fix width instead of double.maxFinite
                                        child: Container(
                                          height: context.heightPct(33 / 812),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: AppColors.stroke,
                                              width: context.widthPct(0.0025),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppStrings.large,
                                              style: AppTextStyles.bodyRegular(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.widthPct(10 / 375),
                                      ),
                                      SizedBox(
                                        width: context.widthPct(
                                          100 / 375,
                                        ), // fix width
                                        child: Container(
                                          height: context.heightPct(33 / 812),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            border: Border.all(
                                              color: AppColors.stroke,
                                              width: context.widthPct(0.0025),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppStrings.medium,
                                              style: AppTextStyles.bodyRegular(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // ✅ Icon on the right
                                  SvgPicture.asset(
                                    ImageAssets.delete,
                                    height: context.heightPct(20 / 812),
                                    width: context.widthPct(20 / 375),
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
