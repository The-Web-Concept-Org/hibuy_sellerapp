import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/orders_bloc/orders_bloc.dart';
import 'package:hibuy/view/dashboard_screen/order_details_screen.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:intl/intl.dart';

class SalereportScreen extends StatefulWidget {
  const SalereportScreen({super.key});

  @override
  State<SalereportScreen> createState() => _SalereportScreenState();
}

class _SalereportScreenState extends State<SalereportScreen> {
  final SingleSelectController<String> orderStatusController =
      SingleSelectController<String>(null);
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Set initial state
    context.read<OrdersBloc>().add(ClearDataEvent());
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.salereport,
        previousPageTitle: "Back",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(17 / 375),
          right: context.widthPct(17 / 375),
          // top: context.heightPct(58 / 812),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.heightPct(12 / 812)),
            // Order Status Dropdown
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPct(10 / 375),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.lightBorderGrey, width: 1),
              ),
              child: CustomDropdown<String>(
                hintText: AppStrings.select,
                closedHeaderPadding: EdgeInsets.zero,
                decoration: CustomDropdownDecoration(
                  hintStyle: AppTextStyles.medium5(context),
                  headerStyle: AppTextStyles.medium5(context),
                  listItemStyle: AppTextStyles.medium5(context),
                ),
                items: const [
                  'All Orders',
                  'Order Placed',
                  'Pending',
                  'Processing',
                  'Shipped',
                  'Delivered',
                  'Cancelled',
                  'Returned',
                ],
                controller: orderStatusController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: context.heightPct(12 / 812)),

            // ✅ Row with two textfields
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From",
                        style: AppTextStyles.cardtext(context).copyWith(
                          fontSize: context.scaledFont(12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: context.heightPct(4 / 812)),
                      GestureDetector(
                        onTap: () => _selectFromDate(context),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat(
                                  'yyyy-MM-dd',
                                ).format(selectedFromDate),
                                style: AppTextStyles.medium5(context),
                              ),
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: AppColors.secondry,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.widthPct(13 / 375)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "To",
                        style: AppTextStyles.cardtext(context).copyWith(
                          fontSize: context.scaledFont(12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: context.heightPct(4 / 812)),
                      GestureDetector(
                        onTap: () => _selectToDate(context),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('yyyy-MM-dd').format(selectedToDate),
                                style: AppTextStyles.medium5(context),
                              ),
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: AppColors.secondry,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(12 / 812)),
            ReusableButton(
              text: AppStrings.applyfilters,
              onPressed: () {
                final displayStatus = orderStatusController.value ?? 'all';
                final apiStatus = _convertDisplayToApiStatus(displayStatus);
                context.read<OrdersBloc>().add(
                  ApplyFilterEvent(
                    fromDate: selectedFromDate,
                    toDate: selectedToDate,
                    orderStatus: apiStatus,
                  ),
                );
              },
            ),
            SizedBox(height: context.heightPct(15 / 812)),
            BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                final orders = state.ordersResponse?.data ?? [];
                final totalOrders = orders.length;
                final totalAmount = orders.fold<double>(
                  0,
                  (sum, order) => sum + (order.grandTotal ?? 0),
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.stroke, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(10 / 375),
                            vertical: context.heightPct(9 / 812),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.totalorders,
                                style: AppTextStyles.cardtext(context),
                              ),
                              SizedBox(height: context.heightPct(4 / 812)),
                              Text(
                                "$totalOrders",
                                style: AppTextStyles.linktext(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.stroke, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.widthPct(10 / 375),
                            vertical: context.heightPct(9 / 812),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.totalamount,
                                style: AppTextStyles.cardtext(context),
                              ),
                              SizedBox(height: context.heightPct(4 / 812)),
                              Text(
                                "Rs. ${totalAmount.toStringAsFixed(2)}",
                                style: AppTextStyles.linktext(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: context.heightPct(16 / 812)),

            // Filtered Orders List
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state.status == OrdersStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == OrdersStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? "Something went wrong"),
                    );
                  }
                  final orders = state.ordersResponse?.data ?? [];
                  if (orders.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders found",
                        style: AppTextStyles.medium2(context),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Orders List Header - only shown when there's data
                      Text(
                        AppStrings.orderslist,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bold4(context),
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final currentOrder = orders[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightBorderGrey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(bottom: 15),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                            currentOrder.trackingId ?? "",
                                            style: AppTextStyles.medium(
                                              context,
                                            ),
                                          ),
                                          Container(
                                            width: context.widthPct(77 / 375),
                                            height: context.heightPct(17 / 812),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: AppColors.stroke,
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                getOrderStatusLabel(
                                                  currentOrder.orderStatus ??
                                                      "",
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
                                                currentOrder.customerName ?? "",
                                                style: AppTextStyles.unselect(
                                                  context,
                                                ),
                                              ),
                                              Text(
                                                currentOrder.phone.toString(),
                                                style: AppTextStyles.regular2(
                                                  context,
                                                ),
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
                                              (currentOrder.rider != null)
                                                  ? Text(
                                                      currentOrder
                                                              .rider!
                                                              .riderName ??
                                                          "",
                                                      style:
                                                          AppTextStyles.regular2(
                                                            context,
                                                          ),
                                                    )
                                                  : SizedBox(),
                                              Text(
                                                currentOrder.orderDate ?? "",
                                                style: AppTextStyles.regular2(
                                                  context,
                                                ),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Rs. ${currentOrder.grandTotal ?? 0}",
                                                style: AppTextStyles.samibold3(
                                                  context,
                                                ),
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
                                              "${AppStrings.deliveryStatus}: ${getOrderStatusLabel(currentOrder.orderStatus ?? "")}",
                                              style: AppTextStyles.unselect(
                                                context,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Future.delayed(
                                                      const Duration(
                                                        milliseconds: 100,
                                                      ),
                                                      () {
                                                        if (context.mounted) {
                                                          Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrderDetailScreen(
                                                                    currentOrder:
                                                                        currentOrder,
                                                                  ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageAssets.eyes,
                                                    height: context.heightPct(
                                                      24 / 812,
                                                    ),
                                                    width: context.widthPct(
                                                      24 / 375,
                                                    ),
                                                    color:
                                                        AppColors.primaryColor,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: context.widthPct(
                                                //     7 / 375,
                                                //   ),
                                                // ),
                                                // SvgPicture.asset(
                                                //   ImageAssets.print,
                                                //   height: context.heightPct(
                                                //     24 / 812,
                                                //   ),
                                                //   width: context.widthPct(
                                                //     24 / 375,
                                                //   ),
                                                //   fit: BoxFit.contain,
                                                // ),
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

                            // Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: AppColors.lightBorderGrey,
                            //     ),
                            //     borderRadius: BorderRadius.circular(5),
                            //   ),
                            //   padding: EdgeInsets.only(bottom: 15),
                            //   margin: EdgeInsets.only(bottom: 15),
                            //   child: Column(
                            //     children: [
                            //       // Top colored header
                            //       Container(
                            //         height: context.heightPct(32 / 812),
                            //         decoration: BoxDecoration(
                            //           color: AppColors.primaryColor,
                            //           borderRadius: const BorderRadius.only(
                            //             topLeft: Radius.circular(4),
                            //             topRight: Radius.circular(4),
                            //           ),
                            //         ),
                            //         child: Padding(
                            //           padding: EdgeInsets.only(
                            //             left: context.widthPct(10 / 375),
                            //             right: context.widthPct(4 / 375),
                            //             top: context.heightPct(7 / 812),
                            //             bottom: context.heightPct(8 / 812),
                            //           ),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               Text(
                            //                 order.trackingId ?? "",
                            //                 style: AppTextStyles.medium(
                            //                   context,
                            //                 ),
                            //               ),
                            //               Container(
                            //                 width: context.widthPct(77 / 375),
                            //                 height: context.heightPct(17 / 812),
                            //                 decoration: BoxDecoration(
                            //                   color: AppColors.white,
                            //                   borderRadius:
                            //                       BorderRadius.circular(5),
                            //                   border: Border.all(
                            //                     color: AppColors.stroke,
                            //                     width: 1,
                            //                   ),
                            //                 ),
                            //                 child: Center(
                            //                   child: Text(
                            //                     getOrderStatusLabel(
                            //                       order.orderStatus ?? "",
                            //                     ),
                            //                     style: AppTextStyles.regular(
                            //                       context,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       // Order details
                            //       Container(
                            //         padding: EdgeInsets.only(
                            //           left: context.widthPct(10 / 375),
                            //           right: context.widthPct(10 / 375),
                            //         ),
                            //         child: Column(
                            //           children: [
                            //             // Name + contact row
                            //             Padding(
                            //               padding: EdgeInsets.only(
                            //                 top: context.heightPct(7 / 812),
                            //                 bottom: context.heightPct(8 / 812),
                            //               ),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text(
                            //                     order.customerName ?? "",
                            //                     style: AppTextStyles.unselect(
                            //                       context,
                            //                     ),
                            //                   ),
                            //                   Text(
                            //                     order.phone.toString(),
                            //                     style: AppTextStyles.regular2(
                            //                       context,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             // Price row
                            //             Padding(
                            //               padding: EdgeInsets.only(
                            //                 top: context.heightPct(7 / 812),
                            //                 bottom: context.heightPct(8 / 812),
                            //               ),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: [
                            //                   Text(
                            //                     "Rs. ${order.grandTotal ?? 0}",
                            //                     style: AppTextStyles.samibold3(
                            //                       context,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getOrderStatusLabel(String status) {
    switch (status) {
      case 'all':
        return 'All Orders';
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
      case 'returned':
        return 'Returned';
      default:
        return 'Unknown Status';
    }
  }

  String _convertDisplayToApiStatus(String displayStatus) {
    switch (displayStatus) {
      case 'All Orders':
        return 'all';
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
      case 'Returned':
        return 'returned';
      default:
        return 'all';
    }
  }
}
