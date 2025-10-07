import 'dart:developer';

import 'package:flutter/material.dart' hide StepState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_bloc.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_event.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/status_step_tile.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: context.screenHeight,
          padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.06)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.heightPct(0.05)),

              /// Logo
              Center(
                child: Image.asset(
                  ImageAssets.app_logo,
                  height: context.heightPct(0.12),
                ),
              ),
              SizedBox(height: context.heightPct(0.01)),

              /// Steps container
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      //height: context.heightPct(0.73),
                      padding: EdgeInsets.all(context.widthPct(19.0 / 375)),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            context.widthPct(14.29 / 375),
                          ),
                          topRight: Radius.circular(
                            context.widthPct(14.29 / 375),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.mystore,
                            style: AppTextStyles.h4(context),
                          ),
                          SizedBox(height: context.heightPct(0.025)),

                          /// Dynamic step list
                          BlocBuilder<StepBloc, StepState>(
                            builder: (context, state) {
                              // Fetch steps data
                              final steps = [
                                {
                                  "title": AppStrings.personalinfo,
                                  "route": RoutesName.personalinformation,
                                },
                                {
                                  "title": AppStrings.mystore,
                                  "route": RoutesName.myStoreInformation,
                                },
                                {
                                  "title": AppStrings.document,
                                  "route": RoutesName.documentVerification,
                                },
                                {
                                  "title": AppStrings.business,
                                  "route": RoutesName.businessVerification,
                                },
                                {
                                  "title": AppStrings.account,
                                  "route": RoutesName.bankAccountVerification,
                                },
                              ];
                              // Set default value for selectedStep
                              int selectedStep = 0;
                              if (state is StepSelectedState) {
                                selectedStep = state
                                    .selectedStep; // Update if state is StepSelectedState
                              }
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(steps.length, (
                                    index,
                                  ) {
                                    bool isSelected =
                                        state is StepSelectedState &&
                                        state.selectedStep == index;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: StatusStepTile(
                                        index: index,
                                        title: steps[index]["title"]!,
                                        isSelected: selectedStep == index,
                                        isCompleted: index < selectedStep,
                                        isLast: index == steps.length - 1,
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            steps[index]["route"]!,
                                          );
                                          context.read<StepBloc>().add(
                                            StepChangedEvent(index),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: context.heightPct(92 / 812)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  ImageAssets.review,
                                  height: context.heightPct(60 / 812),
                                  width: context.widthPct(60 / 375),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                AppStrings.inreview,
                                style: AppTextStyles.h4(context),
                              ),
                              SizedBox(height: context.heightPct(10 / 812)),
                              Text(
                                AppStrings.reviewtext,
                                style: AppTextStyles.unselect(context),
                              ),
                              SizedBox(height: context.heightPct(151 / 812)),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.widthPct(25 / 312),
                              vertical: context.heightPct(20 / 812),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Edit Details Button
                                    Expanded(
                                      child: Container(
                                        height: context.heightPct(40 / 812),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.secondry,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppStrings.editdetails,
                                            style: AppTextStyles.samibold3(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ), // spacing between buttons
                                    // Start Store Button
                                    Expanded(
                                      child: Container(
                                        height: context.heightPct(40 / 812),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppStrings.startstore,
                                            style: AppTextStyles.medium2(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                // Red Button
                                Container(
                                  height: context.heightPct(40 / 812),
                                  width: context.widthPct(102 / 375),
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppStrings.logout,
                                      style: AppTextStyles.medium2(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
