import 'dart:developer';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/orders_bloc/orders_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? selectedOrderStatus;
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? (fromDate ?? DateTime.now())
          : (toDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.black, // ✅ makes "CANCEL" & "OK" visible
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _applyFilters() {
    if (fromDate == null || toDate == null || selectedOrderStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all filter options')),
      );
      return;
    }
    // Navigator.pop(context);

    context.read<OrdersBloc>().add(
      ApplyFilterEvent(
        fromDate: fromDate!,
        toDate: toDate!,
        orderStatus: selectedOrderStatus!,
      ),
    );

    log(
      '✅ Filters applied: from=$fromDate, to=$toDate, status=$selectedOrderStatus',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Container(
        width: screenWidth * 0.8,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text(
                "Order Status",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.stroke, width: 1),
                  borderRadius: BorderRadius.circular(context.widthPct(0.013)),
                ),
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
                  // controller: delieveryStatusController,
                  onChanged: (value) async {
                    setState(
                      () => selectedOrderStatus = getOrderStatusKey(value!),
                    );

                    // String selectedValue = getOrderStatusKey(value!);
                    // log("selected value ------>  $selectedValue}");
                  },
                ),
              ),

              // DropdownButtonFormField<String>(
              //   value: selectedOrderStatus,
              //   hint: const Text("Select"),
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide(color: Colors.grey.shade300),
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(
              //       horizontal: 12,
              //       vertical: 10,
              //     ),
              //   ),
              //   items:
              //       const [
              //             'Order Placed',
              //             'Pending',
              //             'Processing',
              //             'Shipped',
              //             'Delivered',
              //             'Cancelled',
              //             'Returned',
              //           ]
              //           .map(
              //             (status) => DropdownMenuItem(
              //               value: status,
              //               child: Text(status),
              //             ),
              //           )
              //           .toList(),
              //   onChanged: (value) {
              //     setState(() => selectedOrderStatus = value);
              //   },
              // ),
              const SizedBox(height: 20),
              const Text("From", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildDateContainer(isFrom: true),

              const SizedBox(height: 20),
              const Text("To", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildDateContainer(isFrom: false),

              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppColors.lightBorderGrey),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.greytext2(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _applyFilters,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Filter',
                            style: AppTextStyles.medium2(context),
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
  }

  Widget _buildDateContainer({required bool isFrom}) {
    final date = isFrom ? fromDate : toDate;

    return GestureDetector(
      onTap: () => _pickDate(isFrom: isFrom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null
                  ? DateFormat('dd/MM/yyyy').format(date)
                  : 'Select date',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
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
    case 'Returned':
      return 'returned';
    default:
      return 'unknown';
  }
}
