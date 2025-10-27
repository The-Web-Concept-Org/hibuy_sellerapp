import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hibuy/models/return_order_detail_model.dart';

import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/services/app_func.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/order_update/order_update_bloc.dart';
import 'package:hibuy/view/menu_screens/return_order_bloc/return_order_bloc.dart';
import 'package:intl/intl.dart';

import '../../res/app_string/app_string.dart';
import '../../res/colors/app_color.dart';
import '../../res/text_style.dart';
import '../../widgets/profile_widget.dart/app_bar.dart';

class ReturnOrderDetailScreen extends StatefulWidget {
  final String returnOrderId;
  const ReturnOrderDetailScreen({super.key, required this.returnOrderId});

  @override
  State<ReturnOrderDetailScreen> createState() =>
      _ReturnOrderDetailScreenState();
}

class _ReturnOrderDetailScreenState extends State<ReturnOrderDetailScreen> {
  bool isProductsExpanded = false;
  final SingleSelectController<String> delieveryStatusController =
      SingleSelectController<String>(null);

  @override
  initState() {
    super.initState();
    context.read<ReturnOrderBloc>().add(
      GetReturnOrderDetailEvent(widget.returnOrderId),
    );
  }

  @override
  void dispose() {
    delieveryStatusController.dispose();
    super.dispose();
  }
  // void _handleOrderSubmission(String networkVideoUrl) {
  //   final orderVideoPath = context
  //       .read<ImagePickerBloc>()
  //       .state
  //       .images['ordervideo'];
  //   final orderId = widget.orderId;
  //   final String status = delieveryStatusController.value!;

  //   // Check if we have either network video URL or local video file
  //   final hasNetworkVideo = networkVideoUrl.isNotEmpty;
  //   final hasLocalVideo = orderVideoPath != null && orderVideoPath.isNotEmpty;
  //   final hasAnyVideo = hasNetworkVideo || hasLocalVideo;

  //   if (orderId.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Order ID is missing')));
  //   } else if (status.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please select a delivery status')),
  //     );
  //   } else if (!hasAnyVideo) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Please upload a video')));
  //   } else if (size.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Please enter the size')));
  //   } else if (weight.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Please enter the weight')));
  //   } else {
  //     // ✅ All fields valid → Dispatch event
  //     // Only send local video file if we have one and no network video
  //     final File? videoFile = hasLocalVideo && !hasNetworkVideo
  //         ? File(orderVideoPath)
  //         : null;

  //     context.read<OrderUpdateBloc>().add(
  //       UpdateOrderEvent(orderId, status, videoFile, size, weight),
  //     );
  //   }
  //   log("Order video path: ${orderVideoPath}");
  //   log("Network video URL: ${networkVideoUrl}");
  //   log("Has any video: ${hasAnyVideo}");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.personalInformation,
        previousPageTitle: "Order Details",
      ),
      body: SingleChildScrollView(
        padding: context.responsiveAll(0.05),
        child: BlocConsumer<ReturnOrderBloc, ReturnOrderState>(
          listener: (context, state) {
            // if (.returnOrderDetailStatus ==
            //     ReturnOrderDetailStatus.success) {
            //   Navigator.pop(context);
            // }
          },
          builder: (context, state) {
            if (state.returnOrderDetailStatus ==
                ReturnOrderDetailStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.returnOrderDetailStatus ==
                ReturnOrderDetailStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? 'Something went wrong'),
              );
            } else if (state.returnOrderDetailStatus ==
                ReturnOrderDetailStatus.success) {
              // Initialize networkVideoUrl outside the if block

              // Future.delayed(Duration(milliseconds: 100), () {

              log(
                "=> => => =>${AppFunc.orderStatusLabel(state.returnOrderDetail?.returnStatus ?? '')}",
              );
              delieveryStatusController.value = AppFunc.orderStatusLabel(
                state.returnOrderDetail?.returnStatus ?? '',
              );
              // });
              final currentReturn = state.returnOrderDetail;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (widget.isReturn)
                  returnReasonContainer(currentReturn!),

                  SizedBox(height: context.heightPct(0.02)),
                  shipmentDetailsWidget(),
                  SizedBox(height: context.heightPct(0.02)),
                  // if (state.ordersResponse != null)
                  OrderInfoWidget(currentOrder: state.returnOrderDetail!),
                  SizedBox(height: context.heightPct(0.02)),
                  ProductDetailsWidget(
                    products: currentReturn.returnItems,
                    isExpanded: isProductsExpanded,
                    onToggle: () => setState(
                      () => isProductsExpanded = !isProductsExpanded,
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  returnReasonContainer(ReturnOrderDetailModel returnOrder) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightBorderGrey),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Return Reason: ",
                  style: AppTextStyles.regular2(context).copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: returnOrder.returnReason,
                  style: AppTextStyles.regular2(
                    context,
                  ).copyWith(fontSize: 10, color: AppColors.secondry),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          SizedBox(
            height: 90,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: returnOrder.returnImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightBorderGrey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(right: 10),
                    width: 90,
                    child: Image.network(
                      returnOrder.returnImages[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Note: ",
                  style: AppTextStyles.regular2(context).copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: returnOrder.returnNote,
                  style: AppTextStyles.regular2(
                    context,
                  ).copyWith(fontSize: 10, color: AppColors.secondry),
                ),
              ],
            ),
          ),

          // Image.network(returnOrder.returnImages)
        ],
      ),
    );
  }

  shipmentDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delievery Status",
          style: AppTextStyles.regular2(
            context,
          ).copyWith(fontSize: 12, color: AppColors.secondry),
        ),
        SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   child: ReusableTextField(
            //     hintText: AppStrings.select,
            //     labelText: AppStrings.deliveryStatus,
            //     trailingIcon: Icons.expand_more,
            //   ),
            // ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
                height: context.heightPct(0.06),
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPct(0.043),
                ),
                child: CustomDropdown<String>(
                  hintText: 'Select ',
                  closedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    hintStyle: AppTextStyles.normal(context),
                    headerStyle: TextStyle(fontSize: 10),
                    listItemStyle: AppTextStyles.normal(context),
                  ),
                  items: const [
                    'Order Placed',
                    'Pending',
                    'Processing',
                    'Shipped',
                    'Delivered',
                    'Cancelled',
                    "Returned",
                    "Completed",
                  ],
                  controller: delieveryStatusController,
                  onChanged: (value) async {
                    // String selectedValue = returnOrderDetailStatusKey(value!);
                    // log("selected value ------>  $selectedValue}");
                  },
                ),
              ),
            ),
            SizedBox(width: context.widthPct(0.03)),
            Expanded(
              child: BlocBuilder<OrderUpdateBloc, OrderUpdateState>(
                builder: (context, state) {
                  final isLoading =
                      state.orderUpdateStatus == OrderUpdateStatus.loading;

                  return GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<ReturnOrderBloc>().add(
                              UpdateReturnOrdersEvent(
                                widget.returnOrderId,
                                AppFunc.orderStatusLabel(
                                  delieveryStatusController.value!,
                                ),
                              ),
                            );
                          },
                    child: Container(
                      width: context.widthPct(0.9),
                      height: context.heightPct(0.05),
                      decoration: BoxDecoration(
                        color: isLoading
                            ? AppColors.primaryColor.withOpacity(0.7)
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(0.05),
                        ),
                        border: Border.all(color: AppColors.white, width: 1),
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                "Submit",
                                style: AppTextStyles.buttontext(context),
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
    );
  }
}

// shipment_details_widget.dart

class OrderInfoWidget extends StatelessWidget {
  final ReturnOrderDetailModel currentOrder;

  const OrderInfoWidget({super.key, required this.currentOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: context.responsiveAll(0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomerInfo(context),
                SizedBox(height: context.heightPct(0.01)),
                _buildOrderInfo(context),
                SizedBox(height: context.heightPct(0.01)),
                _buildTotalInfo(context),
                SizedBox(height: context.heightPct(0.01)),
                _buildGrandTotal(context),
                SizedBox(height: context.heightPct(0.01)),
                _buildAddress(context),
                SizedBox(height: context.heightPct(0.01)),
                const Divider(),
                SizedBox(height: context.heightPct(0.01)),
                if (currentOrder.riderId != null)
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.heightPct(7 / 812),
                      bottom: context.heightPct(8 / 812),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentOrder.riderDetails!.riderName ?? "",
                              style: AppTextStyles.regular2(context),
                            ),

                            Text(
                              currentOrder.riderDetails?.phone ?? "",
                              style: AppTextStyles.regular2(context),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentOrder.riderDetails!.phone ?? "",
                              style: AppTextStyles.regular2(context),
                            ),

                            Text(
                              currentOrder.riderDetails?.email ?? "",
                              style: AppTextStyles.regular2(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(0.04),
        vertical: context.heightPct(0.015),
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${currentOrder.orderId}/ ${currentOrder.order.trackingId}",
              style: AppTextStyles.samibold2(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ),
          StatusChipWidget(
            status: AppFunc.orderStatusLabel(currentOrder.returnStatus),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.customer}: ${currentOrder.order.customerName}",
      right: "${AppStrings.contact}: ${currentOrder.order.phone}",
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.items}: 1",
      right:
          "(${AppStrings.date}: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(currentOrder.createdAt))})",
    );
  }

  Widget _buildTotalInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.total}: ${currentOrder.returnTotal}",
      right: "${AppStrings.deliveryFee}: ${currentOrder.returnDeliveryFee}",
    );
  }

  Widget _buildGrandTotal(BuildContext context) {
    return Text(
      "${AppStrings.grandTotal}: ${AppStrings.rs} ${currentOrder.returnGrandTotal}",
      style: AppTextStyles.samibold2(context),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Text(
      "${AppStrings.address}: ${currentOrder.order.address}",
      style: AppTextStyles.bodyRegular(context),
    );
  }
}

// product_details_widget.dart
class ProductDetailsWidget extends StatelessWidget {
  final List<ReturnItem> products;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ProductDetailsWidget({
    super.key,
    required this.products,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? null : 0,
            child: isExpanded
                ? _buildProductList(context)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.widthPct(0.04),
          vertical: context.heightPct(0.015),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.productDetails,
              style: AppTextStyles.bold2(context),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.gray2,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: AppColors.stroke),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: context.responsiveAll(0.04),
          itemCount: products.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: context.heightPct(0.02)),
          itemBuilder: (context, index) => ProductTileWidget(
            product: products[index],
            isLastItem: index == products.length - 1,
          ),
        ),
      ],
    );
  }
}

// product_tile_widget.dart
class ProductTileWidget extends StatelessWidget {
  final ReturnItem product;
  final bool isLastItem;

  const ProductTileWidget({
    super.key,
    required this.product,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.responsiveAll(0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(context),
              SizedBox(width: context.widthPct(0.03)),
              Expanded(child: _buildProductInfo(context)),
            ],
          ),
          SizedBox(height: context.heightPct(0.01)),
          _buildPriceInfo(context),
          if (!isLastItem)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(height: 1, color: AppColors.stroke),
            ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      width: context.widthPct(0.2),
      height: context.widthPct(0.17),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        product.image,
        width: 56,
        height: 48,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                product.productName ?? '',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "Qty: ${product.quantity ?? ''}",
              style: TextStyle(color: Colors.black, fontSize: 9),
            ),
          ],
        ),
        SizedBox(height: context.heightPct(0.01)),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //         // "${AppStrings.size}: ${product.size}",
        //         style: AppTextStyles.greytext(context),
        //       ),
        //     ),
        //     Text("1/2 by 4", style: AppTextStyles.bodyRegular(context)),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    final price = product.price ?? 0;
    final quantity = product.quantity ?? 0;
    final total = price * quantity;
    return Row(
      children: [
        Expanded(
          child: Text(
            "${AppStrings.unitPrice}: ${AppStrings.rs}${product.price}",
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          "${AppStrings.subtotal}: ${AppStrings.rs}$total",
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// Reusable Widgets
class StatusChipWidget extends StatelessWidget {
  final String status;

  const StatusChipWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.heightPct(0.03),
      padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.02)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(status, style: AppTextStyles.samibold(context)),
    );
  }
}

class QuantityChipWidget extends StatelessWidget {
  final int quantity;

  const QuantityChipWidget({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.widthPct(0.02),
        vertical: context.heightPct(0.003),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "${AppStrings.qty}: $quantity",
        style: AppTextStyles.samibold(context),
      ),
    );
  }
}

class InfoRowWidget extends StatelessWidget {
  final String left;
  final String right;

  const InfoRowWidget({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(left, style: AppTextStyles.bodyRegular(context))),
        Text(right, style: AppTextStyles.bodyRegular(context)),
      ],
    );
  }
}
