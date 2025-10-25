import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_list/product_list_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_list/product_list_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_list/product_list_state.dart';
import 'package:hibuy/view/dashboard_screen/addproduct_screen.dart';
import 'package:hibuy/view/dashboard_screen/product_details.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Fetch products when screen loads
    context.read<ProductListBloc>().add(FetchProductListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state.status == ProductListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ProductListStatus.success) {
            final products = state.productList?.products ?? [];

            return Padding(
              padding: EdgeInsets.only(
                left: context.widthPct(17 / 375),
                right: context.widthPct(17 / 375),
                top: context.heightPct(58 / 812),
              ),
              child: Column(
                children: [
                  /// Top Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                         
                          context
                              .read<ProductListBloc>()
                              .add(const SetTabBarEvent(selectedIndex: 0));
                        },
                        child: Container(
                          width: context.widthPct(160 / 375),
                          height: context.heightPct(22 / 812),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.stroke, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.allproducts,
                              style: AppTextStyles.allproducts(context),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                         
                          context
                              .read<ProductListBloc>()
                              .add(const SetTabBarEvent(selectedIndex: 1));
                        },
                        child: Container(
                          width: context.widthPct(160 / 375),
                          height: context.heightPct(22 / 812),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.stroke, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.boostedproducts,
                              style: AppTextStyles.boostedproducts(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                 
                  SizedBox(height: context.heightPct(12 / 812)),

                  /// Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: context.heightPct(40 / 812),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(16 / 375),
                            vertical: context.heightPct(12 / 812),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: context.widthPct(18 / 375),
                                color: AppColors.secondry.withOpacity(0.5),
                              ),
                              SizedBox(width: context.widthPct(8 / 375)),
                              Text(
                                AppStrings.searchproduct,
                                style: AppTextStyles.searchtext(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: context.widthPct(9 / 375)),
                      SvgPicture.asset(
                        ImageAssets.searchicon,
                        height: context.heightPct(20 / 812),
                        width: context.widthPct(20 / 375),
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  // SizedBox(height: context.heightPct(12 / 812)),

                  /// Product List
                  Expanded(
                    child: ListView.builder(
                      itemCount:(state.tabBarIndex==0) ?products.length: state.boostedProducts?.length,
                      itemBuilder: (context, index) {
                        final product = state.tabBarIndex==0?products[index] :state.boostedProducts![index];
                        final imageUrl = product.firstImage ?? "";

                        return GestureDetector(
                          onTap: () {
                             final productId = product.productId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     ProductDetailScreen(productId:productId??0,),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: context.heightPct(10 / 812),
                            ),
                            width: double.infinity,
                            height: context.heightPct(91.92 / 812),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.stroke,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.widthPct(9.82 / 375),
                                vertical: context.heightPct(11.22 / 812),
                              ),
                              child: Row(
                                children: [
                                  // ✅ Show image if available else SVG
                                  imageUrl.isNotEmpty
                                      ? Image.network(
                                          "https://dashboard.hibuyo.com/${product?.firstImage ?? ""}",
                                          height: context.heightPct(60 / 812),
                                          width: context.widthPct(60 / 375),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => Image.asset(
                                                "assets/dashboard/image 635.png",
                                              ),
                                        )
                                      : Image.asset(
                                          "assets/dashboard/image 635.png",
                                          height: context.heightPct(60 / 812),
                                          width: context.widthPct(60 / 375),
                                        ),

                                  SizedBox(width: context.widthPct(7 / 375)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.productName ?? "No name",
                                          style: AppTextStyles.samibold3(
                                            context,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: context.heightPct(3 / 812),
                                        ),
                                        Text(
                                          product.productCategory ??
                                              "No category",
                                          style: AppTextStyles.regular2(
                                            context,
                                          ),
                                        ),
                                        SizedBox(
                                          height: context.heightPct(5 / 812),
                                        ),
                                        Text(
                                          (product.productDiscountedPrice ??
                                                  "0")
                                              .toString(),
                                          style: AppTextStyles.samibold3(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.more_vert,
                                        size: context.widthPct(15 / 375),
                                        color: AppColors.black,
                                      ),
                                      SizedBox(
                                        height: context.heightPct(6 / 812),
                                      ),
                                      if (state.productList?.packageStatus !=
                                          null)
                                        Container(
                                          width: context.widthPct(52.62 / 375),
                                          height: context.heightPct(
                                            16.84 / 812,
                                          ),
                                          decoration: BoxDecoration(
                                            color: product.isBoosted == 1
                                                ? AppColors.primaryColor
                                                : AppColors.gray,
                                            borderRadius: BorderRadius.circular(
                                              35,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              product.isBoosted == 1
                                                  ? "boosted"
                                                  : "boost",
                                              style: AppTextStyles.medium(
                                                context,
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        const SizedBox.shrink(),

                                      SizedBox(
                                        height: context.heightPct(3 / 812),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Container(
                                         // width: context.widthPct(52.62 / 375),
                                          height: context.heightPct(16.84 / 812),
                                          decoration: BoxDecoration(
                                            color: AppColors.green,
                                        
                                            borderRadius: BorderRadius.circular(
                                              35,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              product.productStatus == 1
                                                  ? "Active"
                                                  : "Not Active",
                                              style: AppTextStyles.medium(
                                                context,
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state.status == ProductListStatus.error) {
            return Center(
              child: Text(state.message ?? 'Failed to load products'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),

      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddproductScreen()),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
