import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/models/orders_model.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/order_update/order_update_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/orders_bloc/orders_bloc_bloc.dart';

import '../../res/app_string/app_string.dart';
import '../../res/colors/app_color.dart';
import '../../res/text_style.dart';
import '../../widgets/profile_widget.dart/app_bar.dart';
import '../../widgets/profile_widget.dart/button.dart';
import '../../widgets/profile_widget.dart/id_image.dart';
import '../../widgets/profile_widget.dart/text_field.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderData currentOrder;
  const OrderDetailScreen({super.key, required this.currentOrder});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isProductsExpanded = false;
  final SingleSelectController<String> delieveryStatusController =
      SingleSelectController<String>(null);
  TextEditingController weightController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  @override
  initState() {
    super.initState();
    context.read<OrderUpdateBloc>().add(
      GetCompleteOrderEvent(widget.currentOrder.orderId?.toString() ?? ''),
    );
  }

  final OrderDataModel orderData = OrderDataModel(
    trackingId: "TRK-5848184331",
    orderNumber: "3",
    status: AppStrings.inProgress,
    customer: CustomerInfoModel(
      name: "Awais Ansari",
      contact: "0000-00000000",
      address: "123 Maple Street, Block B, Cityville, State 12345, Country",
    ),
    rider: RiderInfoModel(
      name: "Rider Name Here",
      contact: "0000-0000000",
      email: "ad@gmail.com",
      vehicleNumber: "FDS-0000",
    ),
    orderDetails: OrderDetailsModel(
      itemCount: 1,
      date: "25 Aug, 2025",
      total: 0000,
      deliveryFee: 0000,
      grandTotal: 0000,
    ),
    products: [
      ProductInfoModel(
        title: "HD Wireless Bluetooth Headphones with Noise Cancellation",
        quantity: 2,
        size: "Large, Color:black",
        unitPrice: 1200,
      ),
      ProductInfoModel(
        title: "HD Wireless Bluetooth Headphones with Noise Cancellation",
        quantity: 1,
        size: "Medium, Color:black",
        unitPrice: 800,
      ),
    ],
  );

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
        child: BlocConsumer<OrderUpdateBloc, OrderUpdateState>(
          listener: (context, state) {
            if (state.orderUpdateStatus == OrderUpdateStatus.success) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state.status == GetOrderStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == GetOrderStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? 'Something went wrong'),
              );
            }

            if (state.status == GetOrderStatus.success) {
              weightController.text =
                  state.ordersResponse?.orderItems.first.orderWeight
                      .toString() ??
                  '';
              sizeController.text =
                  state.ordersResponse?.orderItems.first.orderSize.toString() ??
                  '';
              Future.delayed(Duration(milliseconds: 100), () {
                delieveryStatusController.value = getOrderStatusLabel(
                  state.ordersResponse?.status ?? '',
                );
              });
              log(
                "${AppUrl.baseUrl}/${state.ordersResponse?.orderItems.first.statusVideo}",
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const ReusableImageContainer(
                //   widthFactor: 0.9,
                //   heightFactor: 0.25,
                //   placeholderSvg: 'ImageAssets.profileimage',
                //   imageKey: 'ordder',
                // ),
                ReusableImageContainer(
                  widthFactor: 0.9,
                  heightFactor: 0.25,
                  placeholderSvg: ImageAssets.profileimage,
                  imageKey: 'ordervideo',
                  isVideo: true,

                  networkImageUrl:
                      "${AppUrl.baseUrl}/${state.ordersResponse?.orderItems.first.statusVideo}",
                  // networkImageUrl:
                  //     authState.documentsShopVideoUrl, // ✅ Network URL
                ),
                SizedBox(height: context.heightPct(0.02)),
                shipmentDetailsWidget(),
                SizedBox(height: context.heightPct(0.02)),
                OrderInfoWidget(currentOrder: widget.currentOrder),
                SizedBox(height: context.heightPct(0.02)),
                ProductDetailsWidget(
                  products: orderData.products,
                  isExpanded: isProductsExpanded,
                  onToggle: () =>
                      setState(() => isProductsExpanded = !isProductsExpanded),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  shipmentDetailsWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ReusableTextField(
                controller: weightController,
                hintText: AppStrings.enterhere,
                labelText: AppStrings.weight,
              ),
            ),
            SizedBox(width: context.widthPct(0.03)),
            Expanded(
              child: ReusableTextField(
                controller: sizeController,
                hintText: AppStrings.sizeHint,
                labelText: AppStrings.size,
              ),
            ),
            // Expanded(child: _buildSizeField(context)),
          ],
        ),
        SizedBox(height: context.heightPct(0.02)),
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
                  ],
                  controller: delieveryStatusController,
                  onChanged: (value) async {
                    String selectedValue = getOrderStatusKey(value!);
                    log("selected value ------>  $selectedValue}");
                  },
                ),
              ),
            ),
            SizedBox(width: context.widthPct(0.03)),
            Expanded(
              child: ReusableButton(
                text:
                    context.read<OrderUpdateBloc>().state.orderUpdateStatus ==
                        OrderUpdateStatus.loading
                    ? "Update"
                    : "Submit",

                // userHeight: context.heightPct(0.07), // proper height
                // userPadding: context.widthPct(0.10),
                // userBorderRadius: 50, // half-circular
                onPressed: () {
                  final homeBillPath = context
                      .read<ImagePickerBloc>()
                      .state
                      .images['ordervideo'];
                  final orderId = widget.currentOrder.orderId?.toString();
                  final String status = delieveryStatusController.value!;
                  final billPath = homeBillPath;
                  final size = sizeController.text.trim();
                  final weight = weightController.text.trim();

                  if (orderId == null || orderId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order ID is missing')),
                    );
                  } else if (status.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a delivery status'),
                      ),
                    );
                  } else if (billPath == null || billPath.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload the home bill file'),
                      ),
                    );
                  } else if (size.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter the size')),
                    );
                  } else if (weight.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter the weight')),
                    );
                  } else {
                    // ✅ All fields valid → Dispatch event
                    context.read<OrderUpdateBloc>().add(
                      UpdateOrderEvent(
                        orderId,
                        status,
                        File(billPath),
                        size,
                        weight,
                      ),
                    );
                  }
                  log("home bill path ${homeBillPath}");
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

// order_info_widget.dart
class OrderInfoWidget extends StatelessWidget {
  final OrderData currentOrder;

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
                const Divider(),
                SizedBox(height: context.heightPct(0.01)),
                _buildGrandTotal(context),
                SizedBox(height: context.heightPct(0.01)),
                _buildAddress(context),
                SizedBox(height: context.heightPct(0.01)),
                const Divider(),
                SizedBox(height: context.heightPct(0.01)),
                if (currentOrder.rider != null) _buildRiderDetails(context),
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
              "${currentOrder.orderId}/ ${currentOrder.trackingId}",
              style: AppTextStyles.samibold2(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ),
          StatusChipWidget(status: currentOrder.status ?? ''),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.customer}: ${currentOrder.customerName}",
      right: "${AppStrings.contact}: ${currentOrder.paid}",
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.items}: 1",
      right: "(${AppStrings.date}: ${currentOrder.orderDate})",
    );
  }

  Widget _buildTotalInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.total}: ${currentOrder.total}",
      right: "(${AppStrings.deliveryFee}: ${currentOrder.deliveryFee})",
    );
  }

  Widget _buildGrandTotal(BuildContext context) {
    return Text(
      "${AppStrings.grandTotal}: ${AppStrings.rs} ${currentOrder.grandTotal}",
      style: AppTextStyles.samibold2(context),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Text(
      "${AppStrings.address}: ${currentOrder.address}",
      style: AppTextStyles.bodyRegular(context),
    );
  }

  Widget _buildRiderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppStrings.riderDetails}:",
          style: AppTextStyles.samibold2(
            context,
          ).copyWith(color: AppColors.primaryColor),
        ),
        SizedBox(height: context.heightPct(0.01)),
        InfoRowWidget(
          left: "${AppStrings.rider}: ${currentOrder.rider?.riderName ?? ''}",
          right:
              "${AppStrings.vehicleNumber} : ${currentOrder.rider?.vehicleType ?? ''}",
        ),
        InfoRowWidget(
          left:
              "${AppStrings.contactNumber}: ${currentOrder.rider?.phone ?? ''}",
          right: "${AppStrings.email}: ${currentOrder.rider?.riderEmail ?? ''}",
        ),
      ],
    );
  }
}

// product_details_widget.dart
class ProductDetailsWidget extends StatelessWidget {
  final List<ProductInfoModel> products;
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
          itemBuilder: (context, index) =>
              ProductTileWidget(product: products[index]),
        ),
      ],
    );
  }
}

// product_tile_widget.dart
class ProductTileWidget extends StatelessWidget {
  final ProductInfoModel product;

  const ProductTileWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.responsiveAll(0.03),
      decoration: BoxDecoration(
        color: AppColors.stroke,
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
      child: Icon(
        Icons.image,
        color: AppColors.gray2,
        size: context.widthPct(0.1),
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
                product.title,
                style: AppTextStyles.samibold2(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            QuantityChipWidget(quantity: product.quantity),
          ],
        ),
        SizedBox(height: context.heightPct(0.01)),
        Row(
          children: [
            Expanded(
              child: Text(
                "${AppStrings.size}: ${product.size}",
                style: AppTextStyles.greytext(context),
              ),
            ),
            Text("1/2 by 4", style: AppTextStyles.bodyRegular(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${AppStrings.unitPrice}: ${AppStrings.rs}${product.unitPrice}",
            style: AppTextStyles.samibold2(context),
          ),
        ),
        Text(
          "${AppStrings.subtotal}: ${AppStrings.rs}${product.unitPrice * product.quantity}",
          style: AppTextStyles.samibold(context),
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

String getOrderStatusKey(String label) {
  switch (label) {
    case 'Order Placed':
      return 'order_placed';
    case 'Pending':
      return 'pending';
    case 'Processing':
      return 'processing';
    case 'Shipped':
      return 'shipped';
    case 'Delivered':
      return 'delivered';
    case 'Cancelled':
      return 'cancelled';
    default:
      return 'unknown';
  }
}

// Data Models
class OrderDataModel {
  final String trackingId;
  final String orderNumber;
  final String status;
  final CustomerInfoModel customer;
  final RiderInfoModel rider;
  final OrderDetailsModel orderDetails;
  final List<ProductInfoModel> products;

  OrderDataModel({
    required this.trackingId,
    required this.orderNumber,
    required this.status,
    required this.customer,
    required this.rider,
    required this.orderDetails,
    required this.products,
  });
}

class CustomerInfoModel {
  final String name;
  final String contact;
  final String address;

  CustomerInfoModel({
    required this.name,
    required this.contact,
    required this.address,
  });
}

class RiderInfoModel {
  final String name;
  final String contact;
  final String email;
  final String vehicleNumber;

  RiderInfoModel({
    required this.name,
    required this.contact,
    required this.email,
    required this.vehicleNumber,
  });
}

class OrderDetailsModel {
  final int itemCount;
  final String date;
  final int total;
  final int deliveryFee;
  final int grandTotal;

  OrderDetailsModel({
    required this.itemCount,
    required this.date,
    required this.total,
    required this.deliveryFee,
    required this.grandTotal,
  });
}

class ProductInfoModel {
  final String title;
  final int quantity;
  final String size;
  final int unitPrice;

  ProductInfoModel({
    required this.title,
    required this.quantity,
    required this.size,
    required this.unitPrice,
  });
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
