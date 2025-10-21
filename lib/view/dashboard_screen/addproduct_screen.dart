import 'dart:io';
import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_state.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/variant_bloc/variant_state.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_state.dart';
import 'package:hibuy/widgets/dashboard/variant_dialog.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';
import 'package:image/image.dart' as img;

class AddproductScreen extends StatefulWidget {
  const AddproductScreen({super.key});

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  // Store selected categories at each level
  List<CategorySelection> selectedCategories = [];

  // Text Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _discountedPriceController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _pricecCntroller = TextEditingController();
  final TextEditingController _stockCntroller = TextEditingController();

  // Focus Nodes
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _brandFocus = FocusNode();
  final FocusNode _purchasePriceFocus = FocusNode();
  final FocusNode _productPriceFocus = FocusNode();
  final FocusNode _discountFocus = FocusNode();
  final FocusNode _discountedPriceFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();
  final FocusNode _lengthFocus = FocusNode();
  final FocusNode _widthFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _stockFocus = FocusNode();

  // Selected vehicle
  String? _selectedVehicle;
  List<dynamic> _filteredVehicles = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _vechiletype();
    _setupDimensionListeners();
  }

  @override
  void dispose() {
    // Dispose controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _purchasePriceController.dispose();
    _productPriceController.dispose();
    _discountController.dispose();
    _discountedPriceController.dispose();
    _weightController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();

    // Dispose focus nodes
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _brandFocus.dispose();
    _purchasePriceFocus.dispose();
    _productPriceFocus.dispose();
    _discountFocus.dispose();
    _discountedPriceFocus.dispose();
    _weightFocus.dispose();
    _lengthFocus.dispose();
    _widthFocus.dispose();
    _heightFocus.dispose();

    super.dispose();
  }

  void _setupDimensionListeners() {
    _weightController.addListener(_filterVehicles);
    _lengthController.addListener(_filterVehicles);
    _widthController.addListener(_filterVehicles);
    _heightController.addListener(_filterVehicles);
  }

  void _filterVehicles() {
    final vehicleState = context.read<VehicleTypeBloc>().state;

    if (vehicleState.status != VehicleTypeStatus.success) return;

    final weight = double.tryParse(_weightController.text) ?? 0;
    final length = double.tryParse(_lengthController.text) ?? 0;
    final width = double.tryParse(_widthController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;

    final allVehicles = vehicleState.vehicleType?.data ?? [];

    // If all dimensions are 0 or empty, show all vehicles
    if (weight == 0 && length == 0 && width == 0 && height == 0) {
      setState(() {
        _filteredVehicles = allVehicles;
      });
      return;
    }

    setState(() {
      _filteredVehicles = allVehicles.where((vehicle) {
        final minWeight = vehicle.minWeight ?? 0;
        final maxWeight = vehicle.maxWeight ?? double.infinity;
        final maxLength = vehicle.maxLength ?? double.infinity;
        final maxWidth = vehicle.maxWidth ?? double.infinity;
        final maxHeight = vehicle.maxHeight ?? double.infinity;

        bool weightMatch = true;
        if (weight > 0) {
          weightMatch = weight >= minWeight && weight <= maxWeight;
        }

        bool lengthMatch = true;
        if (length > 0) {
          lengthMatch = length <= maxLength;
        }

        bool widthMatch = true;
        if (width > 0) {
          widthMatch = width <= maxWidth;
        }

        bool heightMatch = true;
        if (height > 0) {
          heightMatch = height <= maxHeight;
        }

        return weightMatch && lengthMatch && widthMatch && heightMatch;
      }).toList();

      if (_selectedVehicle != null &&
          !_filteredVehicles.any((v) => v.vehicleType == _selectedVehicle)) {
        _selectedVehicle = null;
      }
    });
  }

  void _loadCategories() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCategoryBloc>().add(FetchProductCategoryEvent());
    });
  }

  void _vechiletype() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleTypeBloc>().add(FetchVehicleTypeEvent());
    });
  }

  void _onCategorySelected(dynamic category, int level) {
    setState(() {
      selectedCategories.removeWhere((selection) => selection.level >= level);
      selectedCategories.add(CategorySelection(category, level));
    });

    print('Selected category path:');
    for (var selection in selectedCategories) {
      print('  Level ${selection.level}: ${selection.category.name}');
    }
  }

  List<dynamic> _getCategoriesForLevel(
    int level,
    List<dynamic> rootCategories,
  ) {
    if (level == 0) {
      return rootCategories;
    }

    try {
      final parentSelection = selectedCategories.firstWhere(
        (selection) => selection.level == level - 1,
      );
      return parentSelection.category.children ?? [];
    } catch (e) {
      return [];
    }
  }

  dynamic _getSelectedCategoryAtLevel(int level) {
    try {
      return selectedCategories
          .firstWhere((selection) => selection.level == level)
          .category;
    } catch (e) {
      return null;
    }
  }

  bool _hasChildren(dynamic category) {
    return category.children != null && (category.children as List).isNotEmpty;
  }

  int get _maxLevel {
    if (selectedCategories.isEmpty) return 0;

    final lastSelection = selectedCategories.last;
    return _hasChildren(lastSelection.category)
        ? lastSelection.level + 1
        : lastSelection.level;
  }

  // Validate post image
  Future<bool> _validatePostImage(
    String imagePath,
    BuildContext context,
  ) async {
    try {
      final file = File(imagePath);

      print('\n📸 Post Image Validation:');
      print('   📁 Path: $imagePath');

      // Check file size
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      print('   📊 Size: ${fileSizeInMB.toStringAsFixed(2)} MB');

      // Check image dimensions (MUST be 1080x1080)
      final imageBytes = await file.readAsBytes();
      final image = img.decodeImage(imageBytes);

      if (image == null) {
        print('   ❌ Failed to decode image');
        if (context.mounted) {
          _showErrorDialog(context, 'Invalid image file');
        }
        return false;
      }

      print('   📐 Dimensions: ${image.width}x${image.height} pixels');
      print('   ✓ Required: 1080x1080 pixels');

      if (image.width != 1080 || image.height != 270) {
        print('   ❌ Dimension validation FAILED!');
        print('   ❌ Expected: 1080x1080');
        print('   ❌ Got: ${image.width}x${image.height}');
        if (context.mounted) {
          _showErrorDialog(
            context,
            'Post image MUST be exactly 1080x1080 pixels\n\nYour image: ${image.width}x${image.height} pixels\nRequired: 1080x1080 pixels',
          );
        }
        return false;
      }

      print('   ✅ All validations PASSED');
      return true;
    } catch (e) {
      print('   ❌ Validation error: $e');
      if (context.mounted) {
        _showErrorDialog(context, 'Error validating image: $e');
      }
      return false;
    }
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Invalid Image',
            style: AppTextStyles.bodyRegular(context),
          ),
          content: Text(message, style: AppTextStyles.searchtext(context)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============= VARIANT DIALOG METHODS =============

  void _showVariantDialog({VariantModel? existingVariant, int? index}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) =>
          VariantDialog(existingVariant: existingVariant, variantIndex: index),
    );

    if (result != null) {
      final optionName = result['optionName'] as String;
      final values = result['values'] as List<String>;
      final variantIndex = result['index'] as int?;

      if (variantIndex != null) {
        // Update existing variant
        context.read<VariantBloc>().add(
          UpdateVariantEvent(variantIndex, optionName, values),
        );
      } else {
        // Add new variant
        context.read<VariantBloc>().add(AddVariantEvent(optionName, values));
      }
    }
  }

  Widget _buildCategoryDropdown(
    int level,
    List<dynamic> categories,
    BuildContext context,
  ) {
    if (categories.isEmpty) return const SizedBox.shrink();

    final selectedCategory = _getSelectedCategoryAtLevel(level);
    final List<String> categoryItems = categories
        .map((c) => (c.name ?? "Unnamed").toString())
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (level > 0) SizedBox(height: context.heightPct(12 / 812)),
        Text(
          level == 0
              ? AppStrings.category
              : 'Subcategory ${level > 1 ? level : ''}',
          style: AppTextStyles.bodyRegular(context),
        ),
        SizedBox(height: context.heightPct(0.007)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.stroke, width: 1),
            borderRadius: BorderRadius.circular(context.widthPct(0.013)),
          ),
          height: context.heightPct(0.06),
          padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.043)),
          child: CustomDropdown<String>(
            hintText: 'Select ${level == 0 ? 'category' : 'subcategory'}',
            closedHeaderPadding: EdgeInsets.zero,
            decoration: CustomDropdownDecoration(
              hintStyle: AppTextStyles.normal(context),
            ),
            items: categoryItems,
            initialItem: selectedCategory?.name,
            onChanged: (value) {
              if (value != null) {
                final category = categories.firstWhere((c) => c.name == value);
                _onCategorySelected(category, level);
              }
            },
          ),
        ),
      ],
    );
  }

  // ============= VARIANTS SECTION =============

  Widget _buildVariantsSection(BuildContext context) {
    return BlocBuilder<VariantBloc, VariantState>(
      builder: (context, state) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.stroke,
              width: context.widthPct(0.0025),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: context.widthPct(13 / 375),
              right: context.widthPct(13 / 375),
              top: context.heightPct(7 / 812),
              bottom: context.heightPct(15 / 812),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.variants, style: AppTextStyles.bold4(context)),
                SizedBox(height: context.heightPct(8 / 812)),

                // Add Option Button - FIXED
                GestureDetector(
                  onTap: () => _showVariantDialog(), // Call the method properly
                  child: Container(
                    width: double.maxFinite,
                    height: context.heightPct(46 / 812),
                    decoration: BoxDecoration(
                      color: AppColors.stroke.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.stroke,
                        width: context.widthPct(0.0025),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.addoption,
                        style: AppTextStyles.normal(context),
                      ),
                    ),
                  ),
                ),

                // Display added variants
                if (state.variants.isNotEmpty) ...[
                  SizedBox(height: context.heightPct(10 / 812)),
                  ...List.generate(state.variants.length, (index) {
                    final variant = state.variants[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: context.heightPct(13 / 812),
                      ),
                      child: _buildVariantBox(
                        context,
                        variant.optionName,
                        variant.values,
                        index,
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
  

Widget _buildBexpansiontile(
  BuildContext context,
  VariantModel mainVariant,
  int index,
  List<VariantModel> allVariants,
) {
  // 🧩 Identify secondary variant (e.g., color)
  final VariantModel? subVariant =
      allVariants.length > 1 ? allVariants.last : null;

  // 🧠 Debug prints
  print("➡️ Main Variant: ${mainVariant.optionName}");
  print("   Values: ${mainVariant.values}");
  if (subVariant != null) {
    print("➡️ Sub Variant: ${subVariant.optionName}");
    print("   Values: ${subVariant.values}");
  }

  // 🧩 Create a list of ExpansionTiles — one for each main variant value
  return Column(
    children: List.generate(mainVariant.values.length, (i) {
      // Current main value (e.g. Large, Medium)
      final String mainValue = mainVariant.values[i];

      final List<String> subItems = [
        mainValue,
        if (subVariant != null) ...subVariant.values,
      ];

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: context.heightPct(10 / 812)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.stroke.withOpacity(0.5)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              mainValue, // 👈 Each tile shows its own title (Large, Medium)
              style: AppTextStyles.bold4(context),
            ),
            tilePadding:
                EdgeInsets.symmetric(horizontal: context.widthPct(12 / 375)),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: context.widthPct(16 / 375),
              vertical: context.heightPct(8 / 812),
            ),

            // 🧱 Sub-items (Large, Red, Blue)
            children: subItems.map((value) {
              return Padding(
                padding: EdgeInsets.only(bottom: context.heightPct(10 / 812)),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.stroke.withOpacity(0.5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.widthPct(10 / 375)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🖼️ Image placeholder
                        Container(
                          width: context.widthPct(47 / 375),
                          height: context.widthPct(47 / 375),
                          decoration: BoxDecoration(
                            color: AppColors.stroke.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.stroke),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.black2,
                              size: context.widthPct(18 / 375),
                            ),
                          ),
                        ),
                        SizedBox(width: context.widthPct(10 / 375)),

                        // Variant name, Price & Stock fields
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value,
                                style: AppTextStyles.bold4(context),
                              ),
                              SizedBox(height: context.heightPct(6 / 812)),
                              Row(
                                children: [
                                  Expanded(
                                    child: ReusableTextField(
                                      controller: TextEditingController(),
                                      hintText: "Price",
                                    ),
                                  ),
                                  SizedBox(width: context.widthPct(10 / 375)),
                                  Expanded(
                                    child: ReusableTextField(
                                      controller: TextEditingController(),
                                      hintText: "Stock",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }),
  );
}

  // Updated _buildVariantBox with proper edit functionality
  Widget _buildVariantBox(
    BuildContext context,
    String title,
    List<String> options,
    int index,
  ) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.stroke.withOpacity(0.30),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.stroke,
          width: context.widthPct(0.0025),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: context.widthPct(16 / 375),
          right: context.widthPct(16 / 375),
          top: context.heightPct(12 / 812),
          bottom: context.heightPct(12 / 812),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.bold4(context)),
                GestureDetector(
                  onTap: () {
                    final variant = context
                        .read<VariantBloc>()
                        .state
                        .variants[index];
                    _showVariantDialog(existingVariant: variant, index: index);
                  },
                  child: SvgPicture.asset(
                    ImageAssets.edit,
                    height: context.heightPct(20 / 812),
                    width: context.widthPct(20 / 375),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.heightPct(8 / 812)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: context.widthPct(10 / 375),
                    runSpacing: context.heightPct(8 / 812),
                    children: options.map((option) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.widthPct(16 / 375),
                          vertical: context.heightPct(8 / 812),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.stroke,
                            width: context.widthPct(0.0025),
                          ),
                        ),
                        child: Text(
                          option,
                          style: AppTextStyles.bodyRegular(context),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: context.widthPct(10 / 375)),
                GestureDetector(
                  onTap: () {
                    context.read<VariantBloc>().add(DeleteVariantEvent(index));
                  },
                  child: SvgPicture.asset(
                    ImageAssets.delete,
                    height: context.heightPct(20 / 812),
                    width: context.widthPct(20 / 375),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.addproduct,
        previousPageTitle: "Back",
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductCategoryBloc, ProductCategoryState>(
            listener: (context, state) {
              if (state.status == ProductCategoryStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? "Something went wrong"),
                  ),
                );
              }
            },
          ),
          BlocListener<VehicleTypeBloc, VehicleTypeState>(
            listener: (context, state) {
              if (state.status == VehicleTypeStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message ?? "Failed to load vehicles"),
                  ),
                );
              } else if (state.status == VehicleTypeStatus.success) {
                setState(() {
                  _filteredVehicles = state.vehicleType?.data ?? [];
                });
              }
            },
          ),
          // Add VariantBloc listener for error messages
          BlocListener<VariantBloc, VariantState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (context, categoryState) {
            if (categoryState.status == ProductCategoryStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (categoryState.status == ProductCategoryStatus.success) {
              final categories = categoryState.productCategory?.data ?? [];

              return Padding(
                padding: EdgeInsets.only(
                  left: context.widthPct(17 / 375),
                  right: context.widthPct(17 / 375),
                  top: context.heightPct(12 / 812),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.uploadproductimages,
                        style: AppTextStyles.medium3(context),
                      ),
                      SizedBox(height: context.heightPct(7 / 812)),

                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.regular4(context),
                          children: [
                            TextSpan(text: AppStrings.note),
                            TextSpan(
                              text: AppStrings.spantext,
                              style: AppTextStyles.regular(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(10 / 812)),
                      BlocBuilder<ImagePickerBloc, ImagePickerState>(
                        builder: (context, state) {
                          Map<String, String> postImages = {};

                          if (state is ImagePicked) {
                            postImages = state.images;
                          } else if (state is ImageInitial) {
                            postImages = state.images;
                          }

                          return GridView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: context.isMobile
                                      ? 3
                                      : (context.isTablet ? 4 : 6),
                                  crossAxisSpacing: context.widthPct(20 / 375),
                                  mainAxisSpacing: context.heightPct(20 / 812),
                                ),
                            itemBuilder: (context, index) {
                              String postKey = 'post_image_$index';
                              String? postImagePath = postImages[postKey];

                              return GestureDetector(
                                onTap: () async {
                                  context.read<ImagePickerBloc>().add(
                                    PickImageEvent(postKey),
                                  );

                                  await Future.delayed(
                                    const Duration(milliseconds: 500),
                                  );
                                  final updatedState = context
                                      .read<ImagePickerBloc>()
                                      .state;

                                  if (updatedState is ImagePicked) {
                                    final imagePath =
                                        updatedState.images[postKey];
                                    if (imagePath != null &&
                                        imagePath.isNotEmpty) {
                                      final isValid = await _validatePostImage(
                                        imagePath,
                                        context,
                                      );
                                      if (!isValid) {
                                        context.read<ImagePickerBloc>().add(
                                          RemoveImageEvent(postKey),
                                        );
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  width: context.widthPct(100 / 375),
                                  height: context.heightPct(100 / 812),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      context.widthPct(0.027),
                                    ),
                                    border: Border.all(
                                      color: AppColors.stroke,
                                      width: context.widthPct(0.0025),
                                    ),
                                  ),
                                  child: postImagePath != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            context.widthPct(0.027),
                                          ),
                                          child: Image.file(
                                            File(postImagePath),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        )
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_outlined,
                                                color: AppColors.primaryColor,
                                                size: context.widthPct(
                                                  32 / 375,
                                                ),
                                              ),
                                              SizedBox(
                                                height: context.heightPct(
                                                  5 / 812,
                                                ),
                                              ),
                                              Text(
                                                'Upload',
                                                style:
                                                    AppTextStyles.searchtext(
                                                      context,
                                                    ).copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: context.heightPct(
                                                  2 / 812,
                                                ),
                                              ),
                                              Text(
                                                '1080x1080',
                                                style:
                                                    AppTextStyles.searchtext(
                                                      context,
                                                    ).copyWith(
                                                      fontSize: context
                                                          .widthPct(9 / 375),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: context.heightPct(25 / 812)),

                      ReusableTextField(
                        controller: _titleController,
                        focusNode: _titleFocus,
                        hintText: AppStrings.enterhere,
                        labelText: AppStrings.title,
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      ReusableTextField(
                        controller: _descriptionController,
                        focusNode: _descriptionFocus,
                        hintText: AppStrings.enterhere,
                        labelText: AppStrings.description,
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      ReusableTextField(
                        controller: _brandController,
                        focusNode: _brandFocus,
                        hintText: AppStrings.enterhere,
                        labelText: AppStrings.brand,
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      // RECURSIVE CATEGORY DROPDOWNS
                      ...List.generate(
                        _maxLevel + 1,
                        (level) => _buildCategoryDropdown(
                          level,
                          _getCategoriesForLevel(level, categories),
                          context,
                        ),
                      ),

                      SizedBox(height: context.heightPct(12 / 812)),

                      Row(
                        children: [
                          Expanded(
                            child: ReusableTextField(
                              controller: _purchasePriceController,
                              focusNode: _purchasePriceFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.purchaseprice,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: context.widthPct(13 / 375)),
                          Expanded(
                            child: ReusableTextField(
                              controller: _productPriceController,
                              focusNode: _productPriceFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.productprice,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      Row(
                        children: [
                          Expanded(
                            child: ReusableTextField(
                              controller: _discountController,
                              focusNode: _discountFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.discount,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: context.widthPct(13 / 375)),
                          Expanded(
                            child: ReusableTextField(
                              controller: _discountedPriceController,
                              focusNode: _discountedPriceFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.discountedprice,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      Row(
                        children: [
                          Expanded(
                            child: ReusableTextField(
                              controller: _weightController,
                              focusNode: _weightFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.estimateweight,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: context.widthPct(13 / 375)),
                          Expanded(
                            child: ReusableTextField(
                              controller: _lengthController,
                              focusNode: _lengthFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.length,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      Row(
                        children: [
                          Expanded(
                            child: ReusableTextField(
                              controller: _widthController,
                              focusNode: _widthFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.width,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: context.widthPct(13 / 375)),
                          Expanded(
                            child: ReusableTextField(
                              controller: _heightController,
                              focusNode: _heightFocus,
                              hintText: AppStrings.enterhere,
                              labelText: AppStrings.height,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      // VEHICLE TYPE DROPDOWN
                      BlocBuilder<VehicleTypeBloc, VehicleTypeState>(
                        builder: (context, vehicleState) {
                          if (vehicleState.status ==
                              VehicleTypeStatus.loading) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.vechicle,
                                style: AppTextStyles.bodyRegular(context),
                              ),
                              SizedBox(height: context.heightPct(0.007)),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.stroke,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    context.widthPct(0.013),
                                  ),
                                ),
                                height: context.heightPct(0.06),
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.widthPct(0.043),
                                ),
                                child: CustomDropdown<String>(
                                  hintText: _filteredVehicles.isEmpty
                                      ? 'No vehicles available for these dimensions'
                                      : 'Select vehicle type',
                                  closedHeaderPadding: EdgeInsets.zero,
                                  decoration: CustomDropdownDecoration(
                                    hintStyle: AppTextStyles.normal(context)
                                        .copyWith(
                                          color: _filteredVehicles.isEmpty
                                              ? Colors.red.shade400
                                              : null,
                                        ),
                                  ),
                                  items: _filteredVehicles
                                      .map((v) => v.vehicleType.toString())
                                      .toList(),
                                  initialItem: _selectedVehicle,
                                  onChanged: _filteredVehicles.isEmpty
                                      ? null
                                      : (value) {
                                          setState(() {
                                            _selectedVehicle = value;
                                          });
                                          print('Selected vehicle: $value');
                                        },
                                ),
                              ),
                              if (_weightController.text.isNotEmpty ||
                                  _lengthController.text.isNotEmpty ||
                                  _widthController.text.isNotEmpty ||
                                  _heightController.text.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: context.heightPct(5 / 812),
                                  ),
                                  child: Text(
                                    _filteredVehicles.isEmpty
                                        ? 'Product exceeds all vehicle capacities'
                                        : '${_filteredVehicles.length} suitable vehicle(s) available',
                                    style: AppTextStyles.regular4(context)
                                        .copyWith(
                                          color: _filteredVehicles.isEmpty
                                              ? Colors.red.shade600
                                              : Colors.green.shade600,
                                        ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      // VARIANTS SECTION - NOW PROPERLY INTEGRATED
                      _buildVariantsSection(context),
                      BlocBuilder<VariantBloc, VariantState>(
                        builder: (context, state) {
                          if (state.variants.isEmpty)
                            return const SizedBox.shrink();
                          return Column(
                            children: state.variants.asMap().entries.map((
                              entry,
                            ) {
                              final index = entry.key;
                              final variant = entry.value;
                              print("ibde ====== $index");
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: context.heightPct(12 / 812),
                                ),
                                child: _buildBexpansiontile(
                                  context,
                                  variant,
                                  index,
                                  state.variants,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      SizedBox(height: context.heightPct(30 / 812)),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// Helper class to track category selections
class CategorySelection {
  final dynamic category;
  final int level;

  CategorySelection(this.category, this.level);
}
