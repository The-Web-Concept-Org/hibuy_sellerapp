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
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_event.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';
import 'package:hibuy/view/auth/bloc/kyc_bloc.dart';
import 'package:hibuy/view/auth/bloc/kyc_event.dart';
import 'package:hibuy/view/auth/bloc/kyc_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/status_step_tile.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  @override
  void initState() {
    super.initState();
    context.read<KycBloc>().add(FetchKycData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<KycBloc, KycState>(
        listener: (context, state) {
          if (state.status == KycStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Error loading KYC data"),
              ),
            );
          }
          if (state.status == KycStatus.success) {
            context.read<AuthBloc>().add(
              LoadKycDataToAuthStateEvent(kycResponse: state.kycResponse!),
            );
          }
        },
        builder: (context, state) {
          if (state.status == KycStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == KycStatus.success && state.kycResponse != null) {
            final kycResponse = state.kycResponse!;

            log("KYC Response in UI: ${kycResponse.seller?.sellerId}");
            return _buildKycBody(context, kycResponse);
          }

          // Ensure a Widget is always returned to satisfy non-nullable return type.
          return Center(
            child: Text(state.errorMessage ?? "Error loading KYC data"),
          );
        },
      ),
    );
  }

  Widget _buildKycBody(BuildContext context, kycResponse) {
    final seller = kycResponse.seller;

    if (seller == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, RoutesName.bottomnabBar);
      });
      return const SizedBox.shrink();
    }

    // ✅ Safely get each section (may be null)
    final personalInfo = seller.personalInfo;
    final storeInfo = seller.storeInfo;
    final documentsInfo = seller.documentsInfo;
    final bankInfo = seller.bankInfo;
    final businessInfo = seller.businessInfo;
    return SingleChildScrollView(
      child: Container(
        height: context.screenHeight,
        padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.06)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: context.heightPct(0.05)),

            /// App Logo
            Center(
              child: Image.asset(
                ImageAssets.app_logo,
                height: context.heightPct(0.12),
              ),
            ),
            SizedBox(height: context.heightPct(0.01)),

            /// White container with steps
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.widthPct(19.0 / 375)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  context.widthPct(14.29 / 375),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.mystore, style: AppTextStyles.h4(context)),
                  SizedBox(height: context.heightPct(0.025)),

                  /// Steps List
                  BlocBuilder<StepBloc, StepState>(
                    builder: (context, state) {
                      final personalStatus = personalInfo?.status
                          ?.toLowerCase();
                      final storeStatus = storeInfo?.status?.toLowerCase();
                      final documentStatus = documentsInfo?.status
                          ?.toLowerCase();
                      final bankStatus = bankInfo?.status?.toLowerCase();
                      final businessStatus = businessInfo?.status
                          ?.toLowerCase();
                      log("stats ==>==> ${personalStatus}");
                      final steps = [
                        {
                          "title": AppStrings.personalinfo,
                          "route": RoutesName.personalinformation,
                          "status": personalStatus,
                        },
                        {
                          "title": AppStrings.mystore,
                          "route": RoutesName.myStoreInformation,
                          "status": storeStatus,
                        },
                        {
                          "title": AppStrings.document,
                          "route": RoutesName.documentVerification,
                          "status": documentStatus,
                        },
                        {
                          "title": AppStrings.business,
                          "route": RoutesName.businessVerification,
                          "status": bankStatus,
                        },
                        {
                          "title": AppStrings.account,
                          "route": RoutesName.bankAccountVerification,
                          "status": businessStatus,
                        },
                      ];

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(steps.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: StatusStepTile(
                                index: index,
                                title: steps[index]["title"]!,
                                status: steps[index]["status"]!,
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

                  SizedBox(height: context.heightPct(0.12)),

                  /// Review Section
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
                    ],
                  ),

                  SizedBox(height: context.heightPct(0.15)),

                  /// Buttons
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Edit Details
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // ✅ Load KYC data into AuthBloc for editing

                                final personalStatus = personalInfo?.status
                                    ?.toLowerCase();
                                final storeStatus = storeInfo?.status
                                    ?.toLowerCase();
                                final documentStatus = documentsInfo?.status
                                    ?.toLowerCase();
                                final bankStatus = bankInfo?.status
                                    ?.toLowerCase();
                                final businessStatus = businessInfo?.status
                                    ?.toLowerCase();

                                // ✅ Navigate to rejected step
                                if (personalStatus == 'rejected') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.personalinformation,
                                  );
                                  return;
                                }

                                if (storeStatus == 'rejected') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.myStoreInformation,
                                  );
                                  return;
                                }
                                if (documentStatus == 'rejected') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.documentVerification,
                                  );
                                  return;
                                }
                                if (bankStatus == 'rejected') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.bankAccountVerification,
                                  );
                                  return;
                                }
                                if (businessStatus == 'rejected') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.businessVerification,
                                  );
                                  return;
                                }

                                // If no rejection, go to summary or dashboard
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.kycMain,
                                );
                              },
                              child: Container(
                                height: context.heightPct(40 / 812),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.secondry,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    AppStrings.editdetails,
                                    style: AppTextStyles.samibold3(context),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          /// Start Store Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final status = (seller.status ?? '')
                                    .toString()
                                    .toLowerCase();
                                if (status == 'approved') {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.bottomnabBar,
                                  );
                                  return;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Your status is pending"),
                                      backgroundColor: Colors.orange,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: context.heightPct(40 / 812),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    AppStrings.startstore,
                                    style: AppTextStyles.medium2(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      /// Logout Button
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, authState) {
                          if (authState.logoutStatus == LogoutStatus.success) {
                            // ✅ Navigate to login screen on successful logout
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.signinScreen,
                              (route) => false, // Remove all previous routes
                            );
                          } else if (authState.logoutStatus ==
                              LogoutStatus.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  authState.errorMessage ?? "Logout failed",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, authState) {
                            final isLoading =
                                authState.logoutStatus == LogoutStatus.loading;

                            return GestureDetector(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      // Trigger logout event
                                      context.read<AuthBloc>().add(
                                        LogoutEvent(),
                                      );
                                    },
                              child: Container(
                                height: context.heightPct(40 / 812),
                                width: context.widthPct(102 / 375),
                                decoration: BoxDecoration(
                                  color: isLoading
                                      ? AppColors.red.withOpacity(0.6)
                                      : AppColors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          AppStrings.logout,
                                          style: AppTextStyles.medium2(context),
                                        ),
                                ),
                              ),
                            );
                          },
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
    );
  }
}
