import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/dashboard/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dummy Dashboard Data
    List<DashboardItem> dashboardItems = [
      DashboardItem(
        title: "Total Sales",
        value: "Rs. 00",
        svgIcon: ImageAssets.dollersign,
      ),
      DashboardItem(
        title: "Total Profit",
        value: "Rs. 00",
        svgIcon: ImageAssets.dollersign,
      ),
      DashboardItem(
        title: "Total Expense",
        value: "Rs. 00",
        svgIcon: ImageAssets.dollersign,
      ),
      DashboardItem(
        title: "Net Amount",
        value: "Rs. 00",
        svgIcon: ImageAssets.dollersign,
      ),
      DashboardItem(
        title: "Total Products",
        value: "100",
        svgIcon: ImageAssets.returnsign,
      ),
      DashboardItem(
        title: "Current Orders",
        value: "100",
        svgIcon: ImageAssets.ordersign,
      ),
      DashboardItem(
        title: "Pending Orders",
        value: "100",
        svgIcon: ImageAssets.returnsign,
      ),
      DashboardItem(
        title: "Pending Amount",
        value: "Rs. 5,679",
        svgIcon: ImageAssets.dollersign,
      ),
      DashboardItem(
        title: "Return Orders",
        value: "00",
        svgIcon: ImageAssets.ordersign,
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.widthPct(0.025)),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: dashboardItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isMobile
                    ? 3
                    : (context.isTablet ? 4 : 6),
                crossAxisSpacing: context.widthPct(0.025),
                mainAxisSpacing: context.heightPct(0.015),
                childAspectRatio: 114 / 59.93,
              ),
              itemBuilder: (context, index) {
                final item = dashboardItems[index];
                return Flexible(
                  child: Container(
                    width: context.widthPct(0.3), // ~30% of screen width
                    height: context.heightPct(0.1), // ~10% of screen height
                    padding: EdgeInsets.fromLTRB(
                      context.widthPct(0.015), // left
                      context.heightPct(0.01), // top
                      context.widthPct(0.015), // right
                      context.heightPct(0.01), // bottom
                    ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              item.svgIcon,
                              height: context.heightPct(0.018),
                            ),
                            SizedBox(width: context.widthPct(0.015)),
                            Expanded(
                              child: Text(
                                item.title,
                                style: AppTextStyles.cardtext(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.heightPct(0.008)),
                        Flexible(
                          child: Text(
                            item.value,
                            style: AppTextStyles.cardvalue(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: context.heightPct(10/812)),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  context.widthPct(9.75 / 375),
                ),
                border: Border.all(
                  color: AppColors.stroke,
                  width: context.widthPct(0.7 / 375),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // shadow color
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(context.widthPct(16 / 375)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      AppStrings.topsellingproducts,
                      style: AppTextStyles.boldlato(context),
                    ),
                    SizedBox(height: context.heightPct(15 / 812)),

                    // Table header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            AppStrings.sr,
                            style: AppTextStyles.medium7(context),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            AppStrings.product,
                            style: AppTextStyles.medium7(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppStrings.itemsold,
                              style: AppTextStyles.medium7(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    // Product list
                    _buildProductRow(
                      "1",
                      "assets/dashboard/product.png",
                      "Product Name",
                      "498 pcs",
                    ),
                    const Divider(),
                    _buildProductRow(
                      "2",
                      "assets/dashboard/product.png",
                      "Product Name",
                      "367 pcs",
                    ),
                    const Divider(),
                    _buildProductRow(
                      "3",
                      "assets/dashboard/product.png",
                      "Product Name",
                      "255 pcs",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for product rows
  Widget _buildProductRow(String sr, String img, String name, String sold) {
    return Row(
      children: [
        // Serial No
        Expanded(flex: 1, child: Text(sr)),

        // Product Image + Name
        Expanded(
          flex: 3,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  img,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Text(name),
            ],
          ),
        ),

        // Item Sold
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              sold,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

/// Dashboard Data Model
class DashboardItem {
  final String title;
  final String value;
  final String svgIcon;

  DashboardItem({
    required this.title,
    required this.value,
    required this.svgIcon,
  });
}
