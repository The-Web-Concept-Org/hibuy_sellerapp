import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/services/app_func.dart';
import 'package:hibuy/view/menu_screens/return_order_bloc/return_order_bloc.dart';
import 'package:hibuy/view/menu_screens/return_order_detail_screen.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:intl/intl.dart';

class ReturnorderScreen extends StatefulWidget {
  const ReturnorderScreen({super.key});

  @override
  State<ReturnorderScreen> createState() => _ReturnorderScreenState();
}

class _ReturnorderScreenState extends State<ReturnorderScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ReturnOrderBloc>().add(GetReturnOrdersEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.returnorders,
        previousPageTitle: "Back",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.widthPct(17 / 375),
            right: context.widthPct(17 / 375),
            top: context.heightPct(12 / 812),
            bottom: context.heightPct(12 / 812),
          ),
          child: Column(
            children: [
              /// Search Bar
              BlocListener<ReturnOrderBloc, ReturnOrderState>(
                listener: (context, state) {
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
                          context.read<ReturnOrderBloc>().add(
                            SearchReturnOrdersEvent(value),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: AppStrings.searchproduct,
                          prefixIcon: Icon(
                            Icons.search,
                            size: context.widthPct(18 / 375),
                            color: AppColors.secondry.withOpacity(0.5),
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
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              Expanded(
                child: BlocBuilder<ReturnOrderBloc, ReturnOrderState>(
                  builder: (context, state) {
                    if (state.status == ReturnOrderStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == ReturnOrderStatus.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(height: 16),
                            Text(
                              state.errorMessage ?? "Something went wrong",
                              style: AppTextStyles.medium2(context),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ReturnOrderBloc>().add(
                                  GetReturnOrdersEvent(),
                                );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    final returnOrders =
                        state.returnOrdersResponse?.returnOrders ?? [];

                    if (returnOrders.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64,
                              color: AppColors.secondry,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No return orders found",
                              style: AppTextStyles.medium2(context),
                            ),
                          ],
                        ),
                      );
                    }

                    // Filter orders based on search query
                    final filteredOrders = returnOrders.where((order) {
                      if (state.searchQuery.isEmpty) return true;
                      final searchLower = state.searchQuery.toLowerCase();

                      final customerName =
                          order.order?.customerName.toLowerCase() ?? '';

                      return customerName.contains(searchLower);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final returnOrder = filteredOrders[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
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
                                        returnOrder.order?.trackingId ?? "N/A",
                                        style: AppTextStyles.medium(context),
                                      ),
                                      Container(
                                        width: context.widthPct(77 / 375),
                                        height: context.heightPct(17 / 812),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color: AppColors.stroke,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppFunc.orderStatusLabel(
                                              returnOrder.returnStatus,
                                            ),
                                            style: AppTextStyles.regular(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Content
                              Padding(
                                padding: EdgeInsets.only(
                                  left: context.widthPct(10 / 375),
                                  right: context.widthPct(10 / 375),
                                  top: context.heightPct(15 / 812),
                                  bottom: context.heightPct(15 / 812),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name + phone
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          returnOrder.order?.customerName ??
                                              "N/A",
                                          style: AppTextStyles.unselect(
                                            context,
                                          ),
                                        ),
                                        Text(
                                          returnOrder.order?.phone.toString() ??
                                              "N/A",
                                          style: AppTextStyles.regular2(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: context.heightPct(8 / 812),
                                    ),

                                    // Reason
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        (returnOrder.riderDetails != null)
                                            ? Text(
                                                returnOrder
                                                        .riderDetails
                                                        ?.riderName ??
                                                    '',
                                                style: AppTextStyles.regular2(
                                                  context,
                                                ),
                                              )
                                            : SizedBox(),
                                        Text(
                                          "Date: ${_formatDate(returnOrder.createdAt)}",
                                          style: AppTextStyles.regular2(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: context.heightPct(8 / 812),
                                    ),

                                    // Date

                                    // Grand total
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Reason: ${returnOrder.returnReason}",
                                          style: AppTextStyles.regular2(
                                            context,
                                          ),
                                        ),
                                        Text(
                                          "Rs. ${returnOrder.returnGrandTotal}",
                                          style: AppTextStyles.samibold3(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: context.heightPct(8 / 812),
                                    ),
                                    Divider(color: AppColors.stroke),
                                    SizedBox(
                                      height: context.heightPct(8 / 812),
                                    ),
                                    // Action buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Delievery Status: ${AppFunc.orderStatusLabel(returnOrder.returnStatus)}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (context.mounted) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReturnOrderDetailScreen(
                                                        returnOrderId:
                                                            returnOrder.returnId
                                                                .toString(),
                                                      ),
                                                ),
                                              );
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            ImageAssets.eyes,
                                            height: context.heightPct(24 / 812),
                                            width: context.widthPct(24 / 375),
                                            color: AppColors.primaryColor,
                                            fit: BoxFit.contain,
                                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);

      return DateFormat('d MMM, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
