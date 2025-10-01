import 'package:flutter/material.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart'; // <-- your new extension

class BoostProduct extends StatelessWidget {
  const BoostProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.returnorders,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(0.045), // ~17/375 = 0.045
          right: context.widthPct(0.045),
          top: context.heightPct(0.015), // ~12/812 ≈ 0.015
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Benefits Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: AppColors.stroke, width: 1),
              ),
              elevation: 1,
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
                    _buildBullet(context,
                        "Boost your products to appear at the top of listings"),
                    _buildBullet(context,
                        "Increase product visibility and reach more buyers"),
                    _buildBullet(context,
                        "Get higher chances of sales with promoted products"),
                    _buildBullet(context,
                        "Stand out from competitors in your category"),
                    _buildBullet(context,
                        "Real-time performance insights on boosted items"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Account Details Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 1,
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
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Browse Files"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text("Done"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.medium5(context),
            ),
          ),
        ],
      ),
    );
  }
}
