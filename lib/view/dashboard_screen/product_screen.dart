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
  final TextEditingController searchController = TextEditingController();
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
         final tabProducts=   (state.tabBarIndex == 0)
                ? products
                : state.boostedProducts ?? [];
             final filteredOrders =
                      tabProducts.where((product) {
                        if (state.searchQuery.isEmpty) return true;
                        final searchLower = state.searchQuery.toLowerCase();

                        final productName =
                            product.productName?.toLowerCase() ?? '';

                        return productName.contains(searchLower);
                      }).toList() ??
                      [];
                    

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
                          context.read<ProductListBloc>().add(
                            const SetTabBarEvent(selectedIndex: 0),
                          );
                        },
                        child: Container(
                          width: context.widthPct(160 / 375),
                          height: context.heightPct(22 / 812),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                            ),
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
                          context.read<ProductListBloc>().add(
                            const SetTabBarEvent(selectedIndex: 1),
                          );
                        },
                        child: Container(
                          width: context.widthPct(160 / 375),
                          height: context.heightPct(22 / 812),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                            ),
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
                /// Search Bar
              BlocListener<ProductListBloc, ProductListState>(
                listener: (context, state) {
                  // Clear search field when search query is cleared
                  if (state.searchQuery.isEmpty &&
                      searchController.text.isNotEmpty) {
                    searchController.clear();
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          context.read<ProductListBloc>().add(
                            SearchOrdersEvent(value),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: AppStrings.searchproduct,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: AppColors.hintTextDarkGrey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: AppColors.stroke),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: AppColors.stroke),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(12 / 375),
                            vertical: context.heightPct(10 / 812),
                          ),
                        ),
                      ),),
                  // SizedBox(height: context.heightPct(12 / 812)),
                    // Filter orders based on search query
                 

                  /// Product List
                  Expanded(
                    child: ListView.builder(
                      itemCount:filteredOrders.length,
                      itemBuilder: (context, index) {
                        final product = filteredOrders[index];
                        final imageUrl = product.firstImage ?? "";
                       

                        return GestureDetector(
                          onTap: () {
                            final productId = product.productId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productId: productId ?? 0,
                                ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PopupMenuButton<String>(
                                        color: AppColors.white,
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: context.widthPct(15 / 375),
                                          color: AppColors.black,
                                        ),
                                        onSelected: (String value) {
                                          if (value == 'edit') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddproductScreen(),
                                              ),
                                            );
                                          } else if (value == 'delete') {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('Delete Product'),
                                                content: Text(
                                                  'Are you want this product Deleted?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Delete logic yahan implement karein
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Delete'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                              PopupMenuItem<String>(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('Edit'),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                      ),
                                      // ✅ Remove extra SizedBox heights
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
                                      // ✅ Reduced spacing
                                      SizedBox(
                                        height: context.heightPct(2 / 812),
                                      ),
                                      Container(
                                        height: context.heightPct(16.84 / 812),
                                        decoration: BoxDecoration(
                                          color: AppColors.green,
                                          borderRadius: BorderRadius.circular(
                                            35,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0,
                                            ),
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
            ),
                ]
              )
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
