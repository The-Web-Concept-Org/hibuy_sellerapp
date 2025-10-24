import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hibuy/models/dashboard_model.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/app_url/app_url.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/dashboard%20bloc/dashboard_bloc.dart';
import 'package:hibuy/view/menu_screens/menu%20blocs/bloc/setting_bloc.dart';
import 'package:hibuy/widgets/dashboard/app_bar.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetDashboardDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.widthPct(0.025)),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.status == DashBoardStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == DashBoardStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? "Something went wrong"),
              );
            }
            DashboardData? dashboardData = state.dashboardResponse?.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dashbordItem(
                        title: "Total Sales",
                        value: "Rs.${dashboardData?.revenue ?? '00'}",
                        svgIcon: ImageAssets.dollersign,
                      ),
                      dashbordItem(
                        title: "Total Profit",
                        value: "Rs. ${dashboardData?.totalProfit ?? '00'}",
                        svgIcon: ImageAssets.dollersign,
                      ),
                      dashbordItem(
                        title: "Total Expense",
                        value: "Rs. ${dashboardData?.totalExpense ?? '00'}",
                        svgIcon: ImageAssets.dollersign,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      dashbordItem(
                        title: "Net Amount",
                        value: "Rs. ${dashboardData?.revenue ?? '00'}",
                        svgIcon: ImageAssets.dollersign,
                      ),
                      dashbordItem(
                        title: "Total Products",
                        value: "${dashboardData?.totalProducts ?? '00'}",
                        svgIcon: ImageAssets.returnsign,
                      ),
                      dashbordItem(
                        title: "Current Orders",
                        value: "${dashboardData?.totalOrders ?? '00'}",
                        svgIcon: ImageAssets.ordersign,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      dashbordItem(
                        title: "Pending Orders",
                        value: "${dashboardData?.totalPendingOrders ?? '00'}",
                        svgIcon: ImageAssets.returnsign,
                      ),
                      dashbordItem(
                        title: "Pending Amount",
                        value: "${dashboardData?.pendingAmount ?? '00'}",
                        svgIcon: ImageAssets.returnsign,
                      ),
                      dashbordItem(
                        title: "Return Orders",
                        value: "${dashboardData?.returnedOrders ?? '00'}",
                        svgIcon: ImageAssets.returnsign,
                      ),
                    ],
                  ),

                  // GridView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: dashboardItems.length,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: context.isMobile
                  //         ? 3
                  //         : (context.isTablet ? 4 : 6),
                  //     crossAxisSpacing: context.widthPct(0.025),
                  //     mainAxisSpacing: context.heightPct(0.015),
                  //     childAspectRatio: 114 / 59.93,
                  //   ),
                  //   itemBuilder: (context, index) {
                  //     final item = dashboardItems[index];
                  //     return Container(
                  //       width: context.widthPct(0.3), // ~30% of screen width
                  //       height: context.heightPct(0.1), // ~10% of screen height
                  //       padding: EdgeInsets.fromLTRB(
                  //         context.widthPct(0.015), // left
                  //         context.heightPct(0.01), // top
                  //         context.widthPct(0.015), // right
                  //         context.heightPct(0.01), // bottom
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: AppColors.white,
                  //         borderRadius: BorderRadius.circular(
                  //           context.widthPct(0.027),
                  //         ),
                  //         border: Border.all(
                  //           color: AppColors.stroke,
                  //           width: context.widthPct(0.0025),
                  //         ),
                  //       ),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               SvgPicture.asset(
                  //                 item.svgIcon,
                  //                 height: context.heightPct(0.018),
                  //               ),
                  //               SizedBox(width: context.widthPct(0.015)),
                  //               Expanded(
                  //                 child: Text(
                  //                   item.title,
                  //                   style: AppTextStyles.cardtext(context),
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: context.heightPct(0.008)),
                  //           Flexible(
                  //             child: Text(
                  //               item.value,
                  //               style: AppTextStyles.cardvalue(context),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(height: context.heightPct(10 / 812)),
                  //  Selling Products
                  if (state.dashboardResponse?.topProducts.isNotEmpty ?? false)
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(9.75 / 375),
                        ),
                        border: Border.all(
                          color: AppColors.stroke,
                          width: context.widthPct(0.7 / 375),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.widthPct(16 / 375)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              AppStrings.topsellingproducts,
                              style: AppTextStyles.boldlato(context),
                            ),
                            SizedBox(height: context.heightPct(15 / 812)),

                            // Table header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    AppStrings.sr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    AppStrings.product,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppStrings.itemsold,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),

                              shrinkWrap: true,
                              itemCount:
                                  state.dashboardResponse?.topProducts.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final product =
                                    state.dashboardResponse?.topProducts[index];
                                return _buildProductRow(
                                  state: state,
                                  sr: (index + 1),
                                  img: product?.image ?? '',
                                  name: product?.productName ?? '',
                                  sold: product?.totalSold.toString() ?? '',
                                );
                              },
                            ),

                            // Product list
                            // _buildProductRow(
                            //   "1",
                            //   "assets/dashboard/product.png",
                            //   "Product Name",
                            //   "498 pcs",
                            // ),
                            // const Divider(),
                          ],
                        ),
                      ),
                    ),

                  //  Orders
                  if (state.dashboardResponse?.latestOrders.isNotEmpty ?? false)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          context.widthPct(9.75 / 375),
                        ),
                        border: Border.all(
                          color: AppColors.stroke,
                          width: context.widthPct(0.7 / 375),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.widthPct(16 / 375)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Latest Orders",
                              style: AppTextStyles.boldlato(context),
                            ),
                            SizedBox(height: context.heightPct(15 / 812)),

                            // Table header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    AppStrings.customer,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    AppStrings.product,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppStrings.qty,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  state
                                      .dashboardResponse
                                      ?.latestOrders
                                      .length ??
                                  0,
                              itemBuilder: (context, index) {
                                final latestOrders = state
                                    .dashboardResponse
                                    ?.latestOrders[index];
                                return _orderRow(
                                  state: state,
                                  index: index,
                                  latestOrder: latestOrders!,
                                );
                              },
                            ),

                            // Product list
                            // _buildProductRow(
                            //   "1",
                            //   "assets/dashboard/product.png",
                            //   "Product Name",
                            //   "498 pcs",
                            // ),
                            // const Divider(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper widget for product rows
  Widget _buildProductRow({
    required int sr,
    required String img,
    required String name,
    required String sold,
    required DashboardState state,
  }) {
    return Column(
      children: [
        Row(
          children: [
            // Serial No
            Expanded(
              flex: 1,
              child: Text(sr.toString(), style: TextStyle(fontSize: 12)),
            ),

            // Product Image + Name
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      "${AppUrl.websiteUrl}/$img",
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(name, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            // Item Sold
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text("$sold pcs", style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
        if (sr != state.dashboardResponse?.topProducts.length) Divider(),
      ],
    );
  }

  Widget _orderRow({
    required LatestOrder latestOrder,
    required int index,
    required DashboardState state,
  }) {
    return Column(
      children: [
        Row(
          children: [
            // Serial No
            Expanded(
              flex: 3,
              child: Text(
                latestOrder.customerName.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),

            // Product Image + Name
            Expanded(
              flex: 3,
              child: Text(
                latestOrder.phone.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),

            // Item Sold
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${latestOrder.total.toString()} pcs",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  latestOrder.status.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
        if (index != (state.dashboardResponse?.latestOrders.length ?? 0) - 1)
          Divider(),
      ],
    );
  }

  dashbordItem({
    required String title,
    required String value,
    required String svgIcon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: context.widthPct(0.30), // ~30% of screen width
      height: 90, // ~10% of screen height
      padding: EdgeInsets.fromLTRB(
        10, // ,left
        5, // top
        10, // ri,ght
        5, // bottom
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(context.widthPct(0.027)),
        border: Border.all(
          color: AppColors.stroke,
          width: context.widthPct(0.0025),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(svgIcon, height: 20),
              SizedBox(width: context.widthPct(0.015)),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.cardtext(context),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: context.heightPct(0.008)),
          Text(value, style: AppTextStyles.cardvalue(context)),
        ],
      ),
    );
  }
}

/// Dashboard Data Model
class DashboardItem {
  final String title;
  final String value;
  final String svgIcon;

  DashboardItem({
    required this.title,
    required this.value,
    required this.svgIcon,
  });
}
