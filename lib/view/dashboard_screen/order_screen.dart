import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/models/orders_model.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/routes/routes.dart';
import 'package:hibuy/res/routes/routes_name.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/orders_bloc/orders_bloc_bloc.dart';
import 'package:hibuy/view/dashboard_screen/order_details_screen.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  // TODO : Fix ui
  // TODO : seitch for delievery status
  // TODO : add filter by date
  // TODO : SEARCH FUNCTINOALITY
  // TODO : SORTING FUNCTINOALITY
  // TODO : PAGINATION FUNCTINOALITY
  // TODO: PRINT
  // TODO: VIEW
  // TODO: PRODUCT ID IS MISSING IN RESPONSE
  // TODO: ID have multiple items but video url is same


  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(GetOrdersEvent());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375), // instead of 17
          right: context.widthPct(17 / 375),
          top: context.heightPct(58 / 812), // instead of 58
        ),
        child: Column(
          children: [
            /// Top Tabs
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       width: context.widthPct(160 / 375), // instead of 160
            //       height: context.heightPct(22 / 812), // instead of 22
            //       decoration: BoxDecoration(
            //         color: AppColors.primaryColor,
            //         borderRadius: BorderRadius.circular(20),
            //         border: Border.all(color: AppColors.stroke, width: 1),
            //       ),
            //       child: Center(
            //         child: Text(
            //           AppStrings.allorders,
            //           style: AppTextStyles.allproducts(context),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       width: context.widthPct(160 / 375),
            //       height: context.heightPct(22 / 812),
            //       decoration: BoxDecoration(
            //         color: AppColors.white,
            //         borderRadius: BorderRadius.circular(20),
            //         border: Border.all(color: AppColors.stroke, width: 1),
            //       ),
            //       child: Center(
            //         child: Text(
            //           AppStrings.wholesaleorders,
            //           style: AppTextStyles.boostedproducts(context),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // SizedBox(height: context.heightPct(12 / 812)),

            /// Search Bar
            Row(
              children: [
                Expanded(
                  child: ReusableTextField(
                    hintText: AppStrings.searchproduct,
                    sufixWidget: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: AppColors.hintTextDarkGrey,
                      ),
                    ),
                  ),

                  // Container(
                  //   height: context.heightPct(40 / 812),
                  //   padding: EdgeInsets.fromLTRB(
                  //     context.widthPct(16 / 375), // left
                  //     context.heightPct(12 / 812), // top
                  //     context.widthPct(16 / 375), // right
                  //     context.heightPct(12 / 812), // bottom
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.white,
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(color: AppColors.stroke, width: 1),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.search,
                  //         size: context.widthPct(18 / 375),
                  //         color: AppColors.secondry.withOpacity(0.5),
                  //       ),
                  //       SizedBox(width: context.widthPct(8 / 375)),
                  //       Text(
                  //         AppStrings.searchproduct,
                  //         style: AppTextStyles.searchtext(context),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state.status == OrdersStatus.loading) {
                  return SizedBox(
                    height: context.heightPct(0.7),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.status == OrdersStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? "Something went wrong"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,

                  itemCount: state.ordersResponse?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    OrderData? currentOrder = state.ordersResponse?.data[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightBorderGrey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.only(bottom: 15),
                      margin: EdgeInsets.only(bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Main container background
                          // Container(
                          //   width: double.maxFinite,
                          //   height: context.heightPct(128 / 812),
                          //   decoration: BoxDecoration(
                          //     color: AppColors.white,
                          //     borderRadius: BorderRadius.circular(5),
                          //     border: Border.all(color: AppColors.stroke, width: 1),
                          //   ),
                          // ),

                          // Top colored header
                          Container(
                            height: context.heightPct(32 / 812),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: context.widthPct(10 / 375),
                                right: context.widthPct(4 / 375),
                                top: context.heightPct(7 / 812),
                                bottom: context.heightPct(8 / 812),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currentOrder?.trackingId ?? "",
                                    style: AppTextStyles.medium(context),
                                  ),
                                  Container(
                                    width: context.widthPct(77 / 375),
                                    height: context.heightPct(17 / 812),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: AppColors.stroke,
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        currentOrder?.status ?? "",
                                        style: AppTextStyles.regular(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: context.widthPct(10 / 375),
                              right: context.widthPct(10 / 375),
                            ),
                            child: Column(
                              children: [
                                // Name + contact row
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: context.heightPct(7 / 812),
                                    bottom: context.heightPct(8 / 812),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        currentOrder?.customerName ?? "",
                                        style: AppTextStyles.unselect(context),
                                      ),
                                      Text(
                                        currentOrder?.phone.toString() ?? "",
                                        style: AppTextStyles.regular2(context),
                                      ),
                                    ],
                                  ),
                                ),

                                // Rider + Date row
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: context.heightPct(7 / 812),
                                    bottom: context.heightPct(8 / 812),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (currentOrder?.rider != null)
                                          ? Text(
                                              currentOrder?.rider!.riderName ??
                                                  "",
                                              style: AppTextStyles.regular2(
                                                context,
                                              ),
                                            )
                                          : SizedBox(),
                                      Text(
                                        currentOrder?.orderDate ?? "",
                                        style: AppTextStyles.regular2(context),
                                      ),
                                    ],
                                  ),
                                ),

                                // Price row
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: context.heightPct(7 / 812),
                                    bottom: context.heightPct(8 / 812),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Rs. ${currentOrder?.grandTotal ?? 0}",
                                        style: AppTextStyles.samibold3(context),
                                      ),
                                    ],
                                  ),
                                ),

                                // Divider
                                Divider(color: AppColors.stroke),

                                // Delivery Status + Icons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${AppStrings.deliveryStatus}: ${getOrderStatusLabel(currentOrder?.orderStatus ?? "")}",
                                      style: AppTextStyles.unselect(context),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Future.delayed(
                                              const Duration(milliseconds: 100),
                                              () {
                                                if (context.mounted) {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailScreen(
                                                            currentOrder:
                                                                currentOrder!,
                                                          ),
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                          child: SvgPicture.asset(
                                            ImageAssets.eyes,
                                            height: context.heightPct(24 / 812),
                                            width: context.widthPct(24 / 375),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.widthPct(7 / 375),
                                        ),
                                        SvgPicture.asset(
                                          ImageAssets.print,
                                          height: context.heightPct(24 / 812),
                                          width: context.widthPct(24 / 375),
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getOrderStatusLabel(String status) {
    switch (status) {
      case 'order_placed':
        return 'Order Placed';
      case 'pending':
        return 'Pending';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }
}
