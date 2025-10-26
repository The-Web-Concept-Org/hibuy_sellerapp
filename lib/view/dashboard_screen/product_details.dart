import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

import 'package:hibuy/view/dashboard_screen/Bloc/view_produc/product_details_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/view_produc/product_details_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/view_produc/product_details_state.dart';

import 'package:hibuy/Bloc/product_details_bloc/product_detail_bloc.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_event.dart';
import 'package:hibuy/Bloc/product_details_bloc/product_detail_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailsBloc>()
        .add(FetchProductDetailsEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.productdetail,
        previousPageTitle: "Back",
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state.status == ProductDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductDetailsStatus.error) {
            return Center(child: Text(state.message ?? 'Error loading details'));
          } else if (state.status == ProductDetailsStatus.success) {
            final product = state.productDetails?.product;
            final images = product?.productImages ?? [];
            final isNetwork=images.isNotEmpty;
            // If no images from API, fallback to assets
            final imageList = images.isNotEmpty
                ? images
                : [
                    "assets/dashboard/product.png",
                    "assets/dashboard/product.png",
                    "assets/dashboard/product.png"
                  ];

            return SingleChildScrollView(
              padding: context.responsiveAll(0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 Main Product Image
                  BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, detailState) {
                      final selectedIndex = detailState.selectedIndex;
                      final imagePath = imageList[selectedIndex];


                      return ClipRRect(
                        borderRadius: BorderRadius.circular(11.18),
                        child: isNetwork
                            ? Image.network(
                                "${AppUrl.websiteUrl}/$imagePath",
                                width: context.widthPct(0.9),
                                height: context.heightPct(0.35),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                imagePath,
                                width: context.widthPct(0.9),
                                height: context.heightPct(0.35),
                                fit: BoxFit.cover,
                              ),
                      );
                    },
                  ),

                  SizedBox(height: context.heightPct(0.02)),

                  /// 🔳 Thumbnail Images
                  BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, detailState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(imageList.length, (index) {
                          
                          final isSelected =
                              detailState.selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ProductDetailBloc>()
                                  .add(ChangeImageEvent(index));
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.all(context.widthPct(0.01)),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.red
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: isNetwork
                                    ? Image.network(
                                        "${AppUrl.websiteUrl}/${imageList[index]}",
                                        width: context.widthPct(0.18),
                                        height: context.widthPct(0.18),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        imageList[index],
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

                  /// 🧾 Product Info
                  _buildProductInfoBox(context, product),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  /// 🧩 Info Box
  Widget _buildProductInfoBox(BuildContext context, dynamic product) {
    return Container(
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
          Text("Rs. ${product?.productPrice ?? 'N/A'}",
              style: AppTextStyles.samibold5(context)),
          SizedBox(height: context.heightPct(0.01)),
          Text(
            product?.productName ?? "No name",
            style: AppTextStyles.samibold2(context),
          ),
          SizedBox(height: context.heightPct(0.02)),

          _buildRow(context, AppStrings.category,
              product?.categoryName ?? "Unknown"),
          _buildRow(context, AppStrings.brand,
              product?.productBrand ?? "Not specified"),
          _buildRow(context, AppStrings.discount,
              "${product?.productDiscount ?? 0}%"),
          _buildRow(context, AppStrings.discountedprice,
              "Rs. ${product?.productDiscountedPrice ?? 0}"),

          SizedBox(height: context.heightPct(0.02)),

          /// Description
          Text(AppStrings.description,
              style: AppTextStyles.samibold2(context)),
          SizedBox(height: context.heightPct(0.01)),
          Text(
            product?.productDescription ??
                "No description available for this product.",
            style: AppTextStyles.medium4(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.heightPct(0.008)),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.medium3(context)),
          SizedBox(width: context.widthPct(0.015)),
          Expanded(
            child: Text(value, style: AppTextStyles.medium4(context)),
          ),
        ],
      ),
    );
  }
}
