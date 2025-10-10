import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_details/store_details_state.dart';

class MystoreScreen extends StatefulWidget {
  const MystoreScreen({super.key});

  @override
  State<MystoreScreen> createState() => _MystoreScreenState();
}

class _MystoreScreenState extends State<MystoreScreen> {
  void initState() {
    super.initState();
    context.read<StoreDetailsBloc>().add(StoreEvent()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body:  BlocConsumer<StoreDetailsBloc, StoreDetailState>(
        listener: (context, state) {
          if (state.storeDetailsStatus == StoreDetailsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Something went wrong")),
            );
          }
        },
        builder: (context, state) {
          if (state.storeDetailsStatus == StoreDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.storeDetailsStatus == StoreDetailsStatus.success) {
            final store = state.storeDetailsModel?.storeData;
            return  Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          top: context.heightPct(58 / 812),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My Store", style: AppTextStyles.bold2(context)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.editprofile);
                  },
                  child: Container(
                    width: context.widthPct(119 / 375),
                    height: context.heightPct(30 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.editprofile,
                        style: AppTextStyles.medium2(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(7 / 812)),
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: context.heightPct(90 / 812),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.stroke, width: 0.3),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.primaryColor, AppColors.yellow],
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(
                    top: context.heightPct(8 / 812),
                    left: context.widthPct(7 / 375),
                  ),
                  child: Container(
                    width: context.widthPct(327.22 / 375),
                    height: context.heightPct(72.33 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.stroke, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.widthPct(10 / 375),
                        vertical: context.heightPct(10 / 812),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: context.widthPct(52 / 375),
                            height: context.heightPct(52 / 812),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2.85,
                              ),
                            ),
                            child:     CircleAvatar(
                               backgroundImage:NetworkImage("https://dashboard.hibuyo.com/${store?.storeImage?? ""}"),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: context.widthPct(9 / 375)),
                          Column(
                            children: [
                              Text(
                                  store?.storeName ?? "N/A",
                                  
                                style: AppTextStyles.samibold4(context),
                              ),
                              SizedBox(height: context.heightPct(5 / 812)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.products,
                                    height: context.heightPct(14.44 / 812),
                                    width: context.widthPct(13.99 / 375),
                                    color: AppColors.gray,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: context.widthPct(6 / 375)),
                                  Text(
                                    '105 Product Listed',
                                    style: AppTextStyles.regular2(context),
                                  ),
                                ],
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
            SizedBox(height: context.heightPct(10 / 812)),
            Container(
              width: double.maxFinite,
              height: context.heightPct(146 / 812),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4.43),
                border: Border.all(color: AppColors.stroke, width: 0.3),
              ),
              child: Image.asset("assets/dashboard/image.png"),
            ),
          ],
        ),
    );
  }
 return const Center(child: Text("No data available"));
}
      ),
    );
  }
}
