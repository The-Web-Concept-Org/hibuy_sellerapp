import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_bloc.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_event.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart'; // your extension

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  // Dummy images
  final List<String> images = const [
    "assets/dashboard/product.png",
    "assets/dashboard/product.png",
    "assets/dashboard/product.png",
    "assets/dashboard/product.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.productdetail,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        padding: context.responsiveAll(0.04), // responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Main Image
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(11.18),
                  child: Image.asset(
                    images[state.selectedIndex],
                    width: context.widthPct(0.9),
                    height: context.heightPct(0.35),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            SizedBox(height: context.heightPct(0.02)),

            /// Thumbnails
            BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(images.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ProductDetailBloc>().add(
                              ChangeImageEvent(index),
                            );
                      },
                      child: Container(
                        padding: EdgeInsets.all(context.widthPct(0.01)),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: state.selectedIndex == index
                                ? Colors.red
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            images[index],
                            width: context.widthPct(0.18),
                            height: context.widthPct(0.18),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),

            SizedBox(height: context.heightPct(0.025)),

            /// Product Info Box
            Container(
              width: double.infinity,
              padding: context.responsiveAll(0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFECECEC), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rs. 120.25", style: AppTextStyles.samibold5(context)),
                  SizedBox(height: context.heightPct(0.01)),
                  Text(
                    "Airpods Air Pro 3rd Gen TWS Bluetooth 5.0 Apple",
                    style: AppTextStyles.samibold2(context),
                  ),
                  SizedBox(height: context.heightPct(0.02)),

                  _buildRow(context, AppStrings.category, "Electronics"),
                  _buildRow(context, AppStrings.brand, "TWC Laptops"),
                  _buildRow(context, AppStrings.discount, "20%"),
                  _buildRow(context, AppStrings.discountedprice, "Rs 60000"),

                  SizedBox(height: context.heightPct(0.025)),

                  /// Sizes
                  _buildOptionRow(context, AppStrings.size, [
                    _buildChip(context, "2kg"),
                    _buildChip(context, "3kg"),
                    _buildChip(context, "4kg"),
                    _buildChip(context, "5kg"),
                  ]),

                  SizedBox(height: context.heightPct(0.02)),

                  /// Colors
                  _buildOptionRow(context, AppStrings.color, [
                    _buildChip(context, "Black"),
                    _buildChip(context, "Brown"),
                    _buildChip(context, "White"),
                    _buildChip(context, "Green"),
                  ]),
                ],
              ),
            ),

            SizedBox(height: context.heightPct(0.025)),

            /// Description Box
            Container(
              width: double.infinity,
              padding: context.responsiveAll(0.025),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFECECEC), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.description,
                      style: AppTextStyles.samibold2(context)),
                  SizedBox(height: context.heightPct(0.01)),
                  Text(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Error in vero sapiente odio, error dolore vero temporibus consequatur, nobis veniam odit dignissimos consectetur quae in perferendis doloribus debitis corporis, eaque dicta, repellat amet, illum adipisci vel perferendis dolor! Quis vel consequuntur repellat distinctio rem. Corrupti ratione alias odio, error dolore temporibus consequatur, nobis veniam odit laborum dignissimos consectetur quae vero in perferendis provident quis.",
                    style: AppTextStyles.medium4(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// helper row for info
  Widget _buildRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.heightPct(0.01)),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.medium3(context)),
          SizedBox(width: context.widthPct(0.015)),
          Text(value, style: AppTextStyles.medium4(context)),
        ],
      ),
    );
  }

  /// helper row for options
  Widget _buildOptionRow(
    BuildContext context,
    String title,
    List<Widget> chips,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.medium3(context)),
        SizedBox(width: context.widthPct(0.025)),
        Wrap(spacing: context.widthPct(0.02), children: chips),
      ],
    );
  }

  /// custom chip
  Widget _buildChip(BuildContext context, String label) {
    return Container(
      width: context.widthPct(0.12), // responsive width
      height: context.heightPct(0.04), // responsive height
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.stroke, width: 0.95),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.unselect(context),
      ),
    );
  }
}
