import 'package:flutter/material.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

import '../../res/app_string/app_string.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/text_style.dart';
import '../../widgets/profile_widget.dart/app_bar.dart';
import '../../widgets/profile_widget.dart/button.dart';
import '../../widgets/profile_widget.dart/id_image.dart';
import '../../widgets/profile_widget.dart/text_field.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isProductsExpanded = false;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReusableImageContainer(
              widthFactor: 0.9,
              heightFactor: 0.25,
              placeholderSvg: 'ImageAssets.profileimage',
              imageKey: 'ordder',
            ),
            SizedBox(height: context.heightPct(0.02)),
            const ShipmentDetailsWidget(),
            SizedBox(height: context.heightPct(0.02)),
            OrderInfoWidget(orderData: orderData),
            SizedBox(height: context.heightPct(0.02)),
            ProductDetailsWidget(
              products: orderData.products,
              isExpanded: isProductsExpanded,
              onToggle: () =>
                  setState(() => isProductsExpanded = !isProductsExpanded),
            ),
          ],
        ),
      ),
    );
  }
}

// shipment_details_widget.dart
class ShipmentDetailsWidget extends StatelessWidget {
  const ShipmentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ReusableTextField(
                hintText: AppStrings.enterhere,
                labelText: AppStrings.weight,
              ),
            ),
            SizedBox(width: context.widthPct(0.03)),
            Expanded(
              child: ReusableTextField(
                hintText: AppStrings.sizeHint,
                labelText: AppStrings.size,
              ),
            ),
            // Expanded(child: _buildSizeField(context)),
          ],
        ),
        SizedBox(height: context.heightPct(0.02)),
        Row(
          children: [
            Expanded(
              child: ReusableTextField(
                hintText: AppStrings.select,
                labelText: AppStrings.deliveryStatus,
                trailingIcon: Icons.expand_more,
              ),
            ),
            SizedBox(width: context.widthPct(0.03)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ReusableButton(
                  text: "Submit",
                  // userHeight: context.heightPct(0.07), // proper height
                  // userPadding: context.widthPct(0.10),
                  // userBorderRadius: 50, // half-circular
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// order_info_widget.dart
class OrderInfoWidget extends StatelessWidget {
  final OrderDataModel orderData;

  const OrderInfoWidget({super.key, required this.orderData});

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
                _buildRiderDetails(context),
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
              "${orderData.orderNumber}/ ${orderData.trackingId}",
              style: AppTextStyles.samibold2(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ),
          StatusChipWidget(status: orderData.status),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.customer}: ${orderData.customer.name}",
      right: "${AppStrings.contact}: ${orderData.customer.contact}",
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.items}: ${orderData.orderDetails.itemCount}",
      right: "(${AppStrings.date}: ${orderData.orderDetails.date})",
    );
  }

  Widget _buildTotalInfo(BuildContext context) {
    return InfoRowWidget(
      left: "${AppStrings.total}: ${orderData.orderDetails.total}",
      right:
          "(${AppStrings.deliveryFee}: ${orderData.orderDetails.deliveryFee})",
    );
  }

  Widget _buildGrandTotal(BuildContext context) {
    return Text(
      "${AppStrings.grandTotal}: ${AppStrings.rs} ${orderData.orderDetails.grandTotal}",
      style: AppTextStyles.samibold2(context),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Text(
      "${AppStrings.address}: ${orderData.customer.address}",
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
          left: "${AppStrings.rider}: ${orderData.rider.name}",
          right:
              "${AppStrings.vehicleNumber} : ${orderData.rider.vehicleNumber}",
        ),
        InfoRowWidget(
          left: "${AppStrings.contactNumber}: ${orderData.rider.contact}",
          right: "${AppStrings.email}: ${orderData.rider.email}",
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
