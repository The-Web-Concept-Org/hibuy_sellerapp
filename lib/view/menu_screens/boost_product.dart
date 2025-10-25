import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/boost%20bloc/boost_menu_bloc.dart';
import 'package:hibuy/models/boost_status.dart';
import 'package:hibuy/view/menu_screens/fullscreen_image_viewer.dart';

class BoostProduct extends StatefulWidget {
  const BoostProduct({super.key});

  @override
  State<BoostProduct> createState() => _BoostProductState();
}

class _BoostProductState extends State<BoostProduct> {
  @override
  void initState() {
    super.initState();
    // Fetch boost status when screen loads
    context.read<BoostMenuBloc>().add(BoostMenuEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.boostproducts,
        previousPageTitle: "Back",
      ),
      body: BlocBuilder<BoostMenuBloc, BoostMenuState>(
        builder: (context, state) {
          if (state.status == BoostMenuStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BoostMenuStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message ?? "Something went wrong"}',
                    style: AppTextStyles.medium2(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<BoostMenuBloc>().add(BoostMenuEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show different UI based on boost status
          if (state.isBoosted && state.boostStatus != null) {
            return _buildBoostedUserUI(context, state.boostStatus!);
          } else {
            return _buildNonBoostedUserUI(context);
          }
        },
      ),
    );
  }

  Widget _buildBoostedUserUI(BuildContext context, BoostStatus boostStatus) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.widthPct(0.045),
        right: context.widthPct(0.045),
        top: context.heightPct(0.015),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Package Status Card
          Container(
            width: double.infinity,
            height: context.heightPct(108 / 812),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.refealBg),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Member Since",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  boostStatus.packageDetail?.packageStartDate ?? "N/A",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.lightBorderGrey, width: 2),
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rs 1000",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(" /month", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Text(
                    "Next Payment Date",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondry,
                    ),
                  ),
                  Text(
                    boostStatus.packageDetail?.packageEndDate ?? "N/A",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondry,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (boostStatus.packageDetail?.transactionImage != null &&
                          boostStatus
                              .packageDetail!
                              .transactionImage
                              .isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImageViewer(
                              imageUrl:
                                  "${AppUrl.websiteUrl}/storage/${boostStatus.packageDetail!.transactionImage}",
                              title: "Transaction Invoice",
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No invoice image available'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "View Invoice",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.heightPct(12 / 812)),
          const SizedBox(height: 16),
          // Benefits Card
        ],
      ),
    );
  }

  Widget _buildNonBoostedUserUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.widthPct(0.045),
        right: context.widthPct(0.045),
        top: context.heightPct(0.015),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Benefits Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.lightBorderGrey, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.benefitsyouwillget,
                    style: AppTextStyles.samibold2(context),
                  ),
                  const SizedBox(height: 10),
                  _buildBullet(
                    context,
                    "Boost your products to appear at the top of listings",
                  ),
                  _buildBullet(
                    context,
                    "Increase product visibility and reach more buyers",
                  ),
                  _buildBullet(
                    context,
                    "Get higher chances of sales with promoted products",
                  ),
                  _buildBullet(
                    context,
                    "Stand out from competitors in your category",
                  ),
                  _buildBullet(
                    context,
                    "Real-time performance insights on boosted items",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Account Details Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.lightBorderGrey, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.accountdetails,
                    style: AppTextStyles.samibold2(context),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppStrings.bankdetails,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildBullet(context, "Account Name: HiBuy"),
                  _buildBullet(context, "Account Number: 1234567890"),
                  _buildBullet(context, "Bank Name: Bank Name"),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.uploadpaymentproof,
                    style: AppTextStyles.samibold2(context),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gray2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.upload_file),
                              Text(
                                "Browse Files",
                                style: AppTextStyles.medium5(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: AppTextStyles.allproducts(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text, style: AppTextStyles.medium5(context))),
        ],
      ),
    );
  }
}
