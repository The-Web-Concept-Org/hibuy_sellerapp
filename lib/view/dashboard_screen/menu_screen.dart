// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hibuy/models/seller_details.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/services/app_const.dart';
import 'package:hibuy/services/hive_helper.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/view/auth/signin_screen.dart';
import 'package:hibuy/view/menu_screens/boost_product.dart';
import 'package:hibuy/view/menu_screens/inquiries_screen.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';
import 'package:hibuy/view/menu_screens/otherproduct_screen.dart';
import 'package:hibuy/view/menu_screens/purchases_screen.dart';
import 'package:hibuy/view/menu_screens/queries_screen.dart';
import 'package:hibuy/view/menu_screens/returnorder_screen.dart';
import 'package:hibuy/view/menu_screens/salereport_screen.dart';
import 'package:hibuy/view/menu_screens/setting_screen.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    checkOldData();
  }

  checkOldData() async {
    final sellerDetails = await HiveHelper.getData<SellerDetails>(
      AppConst.sellerHiveBox,
      AppConst.sellerHiveKey,
    );
    if (sellerDetails != null) {
      context.read<SettingBloc>().add(
        CheckOldData(sellerDetails: sellerDetails),
      );
    } else {
      context.read<SettingBloc>().add(GetUserDataEvent());
    }
  }

  final List<MenuOption> options = [
    MenuOption(
      svgAsset: ImageAssets.setting,
      title: AppStrings.settings,
      route: MaterialPageRoute(builder: (context) => SettingScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.returnorder,
      title: AppStrings.returnorders,
      route: MaterialPageRoute(builder: (context) => ReturnorderScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.products,
      title: AppStrings.sellerproducts,
      route: MaterialPageRoute(builder: (context) => OtherproductScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.purhases,
      title: AppStrings.purchases,
      route: MaterialPageRoute(builder: (context) => PurchasesScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.inqueries,
      title: AppStrings.inquiries,
      route: MaterialPageRoute(builder: (context) => InquiriesScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.boost,
      title: AppStrings.boostproducts,
      route: MaterialPageRoute(builder: (context) => BoostProduct()),
    ),
    MenuOption(
      svgAsset: ImageAssets.queries,
      title: AppStrings.queries,
      route: MaterialPageRoute(builder: (context) => QueriesScreen()),
    ),
    MenuOption(
      svgAsset: ImageAssets.setting,
      title: AppStrings.salereport,
      route: MaterialPageRoute(builder: (context) => SalereportScreen()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(16 / 375), // responsive padding
          right: context.widthPct(16 / 375),
          top: context.heightPct(56 / 812),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Profile Header Card
              BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
                  if (state.status == SettingStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == SettingStatus.success) {
                    return Container(
                      width: double.infinity,
                      height: context.heightPct(139 / 812),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.stroke, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(19 / 375),
                          vertical: context.heightPct(21 / 812),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    width: context.widthPct(64 / 375),
                                    height: context.heightPct(64 / 812),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 2.85,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(100),
                                      child:
                                          state.sellerDetails?.profilePicture !=
                                              null
                                          ? Image.network(
                                              fit: BoxFit.fill,
                                              "${AppUrl.websiteUrl}/${state.sellerDetails?.profilePicture ?? ''}",
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: context.widthPct(9 / 375)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.sellerDetails?.name ?? '',
                                        style: AppTextStyles.buttontext(
                                          context,
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.heightPct(5 / 812),
                                      ),
                                      Text(
                                        state.sellerDetails?.phone.toString() ??
                                            '',
                                        style: AppTextStyles.medium(context),
                                      ),
                                      SizedBox(
                                        height: context.heightPct(5 / 812),
                                      ),
                                      Text(
                                        state.sellerDetails?.email ?? '',
                                        style: AppTextStyles.medium(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: context.heightPct(10 / 812)),
                            Flexible(
                              child: Text(
                                state.sellerDetails?.address ?? '',
                                style: AppTextStyles.medium(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(state.message ?? "Something went wrong"),
                    );
                  }
                },
              ),

              // SizedBox(height: context.heightPct(20 / 812)),

              /// Menu List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final item = options[index];
                  return GestureDetector(
                    onTap: () {
                      if (item.route != null) {
                        Navigator.push(context, item.route!);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: context.heightPct(55 / 812),
                      ),
                      margin: EdgeInsets.only(
                        bottom: context.heightPct(10 / 812),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(10 / 375),
                        vertical: context.heightPct(15 / 812),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.stroke, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                item.svgAsset,
                                color: AppColors.secondry,
                                width: context.widthPct(15 / 375),
                                height: context.widthPct(15 / 375),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: context.widthPct(10 / 375)),
                              Text(
                                item.title,
                                style: AppTextStyles.medium3(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.secondry,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.logoutStatus == LogoutStatus.success) {
                    // ✅ Navigate to login screen on successful logout
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   RoutesName.signinScreen,
                    //   (route) => false, // Remove all previous routes
                    // );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SigninScreen()),
                      (route) => false,
                    );
                  } else if (state.logoutStatus == LogoutStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage ?? "Logout failed"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                    child: Container(
                      width: context.widthPct(1),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: Center(
                        child: Text(
                          state.logoutStatus == LogoutStatus.loading
                              ? "Logging out..."
                              : "Logout",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: context.scaledFont(14), // 12
                            height: 1.5,
                            letterSpacing: 0.5,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// MenuOption Model

class MenuOption {
  final String svgAsset;
  final String title;
  final MaterialPageRoute? route;
  MenuOption({required this.svgAsset, required this.title, this.route});
}
