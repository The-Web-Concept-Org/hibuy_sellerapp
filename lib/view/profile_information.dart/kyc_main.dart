import 'package:flutter/material.dart' hide StepState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_bloc.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_event.dart';
import 'package:hibuy/Bloc/profile_bloc.dart/steptile_bloc/steptile_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';

import 'package:hibuy/widgets/profile_widget.dart/step_tile.dart'; // Import BLoC

class KycMain extends StatelessWidget {
  const KycMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
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
                            AppStrings.applyforProfile,
                            style: AppTextStyles.h4(context),
                          ),
                          SizedBox(height: context.heightPct(0.025)),

                          /// Dynamic step list
                          BlocBuilder<StepBloc, StepState>(
                            builder: (context, state) {
                              // Fetch steps data
                              final steps = [
                                {
                                  "title": AppStrings.personalInformation,
                                  "subtitle": AppStrings.text,
                                  "route": RoutesName.personalinformation,
                                },
                                {
                                  "title": AppStrings.myStoreInformation,
                                  "subtitle": AppStrings.text,
                                  "route": RoutesName.MyStoreInformation,
                                },
                                {
                                  "title": AppStrings.documentVerification,
                                  "subtitle": AppStrings.text,
                                  "route": RoutesName.DocumentVerification,
                                },
                                {
                                  "title": AppStrings.businessVerification,
                                  "subtitle": AppStrings.text,
                                  "route": RoutesName.BusinessVerification,
                                },
                                {
                                  "title": AppStrings.bankAccountVerification,
                                  "subtitle": AppStrings.text,
                                  "route": RoutesName.BankAccountVerification,
                                },
                              ];
                              // Set default value for selectedStep
                              int selectedStep = 0;
                              if (state is StepSelectedState) {
                                selectedStep = state
                                    .selectedStep; // Update if state is StepSelectedState
                              }
                              return Column(
                                children: List.generate(steps.length, (index) {
                                  bool isSelected =
                                      state is StepSelectedState &&
                                      state.selectedStep == index;
                                  return StepTile(
                                    index: index,
                                    title: steps[index]["title"]!,
                                    subtitle: steps[index]["subtitle"]!,
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
                                  );
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background container
                        Container(
                          width: double.infinity,
                          height: context.heightPct(57.1667 / 812),
                          padding: EdgeInsets.only(
                            top: context.heightPct(9.53 / 812),
                            right: context.widthPct(19.06 / 375),
                            bottom: context.heightPct(9.53 / 812),
                            left: context.widthPct(19.06 / 375),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.gray.withOpacity(0.50),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                context.widthPct(14.29 / 375),
                              ),
                              bottomRight: Radius.circular(
                                context.widthPct(14.29 / 375),
                              ),
                            ),
                          ),
                        ),

                        // Second container in center
                        Center(
                          child: Flexible(
                            child: Container(
                              width: context.widthPct(264.17 / 375),
                              //height: context.heightPct(38.11 / 812),
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(28.58 / 375),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gray.withOpacity(0.50),
                                borderRadius: BorderRadius.circular(
                                  context.widthPct(95.28 / 375),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppStrings.fillalldetails,
                                  style: AppTextStyles.samibold(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
