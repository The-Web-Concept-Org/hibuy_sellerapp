import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/product_category/productcategory_state.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/vechicle_type/vehicle_type_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';

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
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _discountedPriceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

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

    // If all dimensions are 0 or empty, show all vehicles
    if (weight == 0 && length == 0 && width == 0 && height == 0) {
      setState(() {
        _filteredVehicles = vehicleState.vehicleType?.data ?? [];
      });
      return;
    }

    final allVehicles = vehicleState.vehicleType?.data ?? [];
    
    setState(() {
      _filteredVehicles = allVehicles.where((vehicle) {
        // Check weight constraints
        final minWeight = vehicle.minWeight ?? 0;
        final maxWeight = vehicle.maxWeight ?? double.infinity;
        final maxLength = vehicle.maxLength ?? double.infinity;
        final maxWidth = vehicle.maxWidth ?? double.infinity;
        final maxHeight = vehicle.maxHeight ?? double.infinity;

        bool weightMatch = weight >= minWeight && weight <= maxWeight;
        bool lengthMatch = length == 0 || length <= maxLength;
        bool widthMatch = width == 0 || width <= maxWidth;
        bool heightMatch = height == 0 || height <= maxHeight;

        return weightMatch && lengthMatch && widthMatch && heightMatch;
      }).toList();

      // Reset selected vehicle if it's not in filtered list
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
      // Remove all selections after this level
      selectedCategories.removeWhere((selection) => selection.level >= level);
      
      // Add the new selection
      selectedCategories.add(CategorySelection(category, level));
    });

    // Print the full selection path
    print('Selected category path:');
    for (var selection in selectedCategories) {
      print('  Level ${selection.level}: ${selection.category.name}');
    }
  }

  List<dynamic> _getCategoriesForLevel(int level, List<dynamic> rootCategories) {
    if (level == 0) {
      return rootCategories;
    }

    // Get the parent category from previous level
    try {
      final parentSelection = selectedCategories.firstWhere(
        (selection) => selection.level == level - 1,
      );
      
      // Return children if they exist
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
    return category.children != null && 
           (category.children as List).isNotEmpty;
  }

  int get _maxLevel {
    if (selectedCategories.isEmpty) return 0;
    
    final lastSelection = selectedCategories.last;
    return _hasChildren(lastSelection.category)
        ? lastSelection.level + 1
        : lastSelection.level;
  }

  Widget _buildCategoryDropdown(
    int level,
    List<dynamic> categories,
    BuildContext context,
  ) {
    if (categories.isEmpty) return const SizedBox.shrink();

    final selectedCategory = _getSelectedCategoryAtLevel(level);
    final List<String> categoryItems =
        categories.map((c) => (c.name ?? "Unnamed").toString()).toList();
    
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
          padding: EdgeInsets.symmetric(
            horizontal: context.widthPct(0.043),
          ),
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
                // Find the actual category object
                final category = categories.firstWhere(
                  (c) => c.name == value,
                );
                _onCategorySelected(category, level);
              }
            },
          ),
        ),
      ],
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
                  SnackBar(content: Text(state.message ?? "Something went wrong")),
                );
              }
            },
          ),
          BlocListener<VehicleTypeBloc, VehicleTypeState>(
            listener: (context, state) {
              if (state.status == VehicleTypeStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "Failed to load vehicles")),
                );
              } else if (state.status == VehicleTypeStatus.success) {
                setState(() {
                  _filteredVehicles = state.vehicleType?.data ?? [];
                });
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
                              style: AppTextStyles.regular(context)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.heightPct(10 / 812)),

                      GridView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isMobile
                              ? 3
                              : (context.isTablet ? 4 : 6),
                          crossAxisSpacing: context.widthPct(20 / 375),
                          mainAxisSpacing: context.heightPct(20 / 812),
                        ),
                        itemBuilder: (context, index) {
                          return Container(
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
                            child: Center(
                              child: SvgPicture.asset(
                                ImageAssets.profileimage,
                                height: context.heightPct(15 / 812),
                                width: context.widthPct(36 / 375),
                              ),
                            ),
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
                          if (vehicleState.status == VehicleTypeStatus.loading) {
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
                                  border: Border.all(color: AppColors.stroke, width: 1),
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
                                      ? 'No vehicles match dimensions' 
                                      : 'Select vehicle',
                                  closedHeaderPadding: EdgeInsets.zero,
                                  decoration: CustomDropdownDecoration(
                                    hintStyle: AppTextStyles.normal(context),
                                  ),
                                  items: _filteredVehicles
                                      .map((v) => v.vehicleType.toString())
                                      .toList(),
                                  initialItem: _selectedVehicle,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedVehicle = value;
                                    });
                                    print('Selected vehicle: $value');
                                  },
                                ),
                              ),
                              if (_filteredVehicles.isNotEmpty && 
                                  (_weightController.text.isNotEmpty ||
                                   _lengthController.text.isNotEmpty ||
                                   _widthController.text.isNotEmpty ||
                                   _heightController.text.isNotEmpty))
                                Padding(
                                  padding: EdgeInsets.only(top: context.heightPct(5 / 812)),
                                  child: Text(
                                    '${_filteredVehicles.length} vehicle(s) available for dimensions',
                                    style: AppTextStyles.regular4(context),
                                        
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: context.heightPct(12 / 812)),

                      // Variants Container
                      Container(
                        width: double.maxFinite,
                        height: context.heightPct(288 / 812),
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
                              Text(
                                AppStrings.variants,
                                style: AppTextStyles.bold4(context),
                              ),
                              SizedBox(height: context.heightPct(8 / 812)),
                              Container(
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
                              SizedBox(height: context.heightPct(10 / 812)),
                              _buildVariantBox(
                                context,
                                AppStrings.color,
                                [AppStrings.blue, AppStrings.green],
                              ),
                              SizedBox(height: context.heightPct(13 / 812)),
                              _buildVariantBox(
                                context,
                                AppStrings.size,
                                [AppStrings.large, AppStrings.medium],
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildVariantBox(
    BuildContext context,
    String title,
    List<String> options,
  ) {
    return Container(
      width: double.maxFinite,
      height: context.heightPct(85 / 812),
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
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.bold4(context)),
                SvgPicture.asset(
                  ImageAssets.edit,
                  height: context.heightPct(20 / 812),
                  width: context.widthPct(20 / 375),
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: context.heightPct(5 / 812)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: options
                      .map((option) => Padding(
                            padding: EdgeInsets.only(
                              right: context.widthPct(10 / 375),
                            ),
                            child: Container(
                              width: context.widthPct(100 / 375),
                              height: context.heightPct(33 / 812),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColors.stroke,
                                  width: context.widthPct(0.0025),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  option,
                                  style: AppTextStyles.bodyRegular(context),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SvgPicture.asset(
                  ImageAssets.delete,
                  height: context.heightPct(20 / 812),
                  width: context.widthPct(20 / 375),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
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