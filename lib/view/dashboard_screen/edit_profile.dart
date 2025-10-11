import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/app_string/app_string.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/text_style.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_bloc.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_event.dart';
import 'package:hibuy/view/dashboard_screen/Bloc/store_update/store_update_state.dart';
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';
import 'package:image/image.dart' as img;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final List<String> _tags = [];

  @override
  void dispose() {
    _storeNameController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  // Validate banner image
  Future<bool> _validateBannerImage(String imagePath, BuildContext context) async {
    try {
      final file = File(imagePath);
      
      // Check file size (max 2MB)
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      
      print('🖼️ Banner Image Validation:');
      print('   Path: $imagePath');
      print('   Size: ${fileSizeInMB.toStringAsFixed(2)} MB');
      
      if (fileSizeInMB > 2) {
        print('   ❌ Size validation failed: ${fileSizeInMB.toStringAsFixed(2)} MB > 2 MB');
        _showErrorDialog(context, 'Banner image must be maximum 2MB');
        return false;
      }
      
      // Check image dimensions (1280x320)
      final imageBytes = await file.readAsBytes();
      final image = img.decodeImage(imageBytes);
      
      if (image == null) {
        print('   ❌ Failed to decode image');
        _showErrorDialog(context, 'Invalid image file');
        return false;
      }
      
      print('   Dimensions: ${image.width}x${image.height} pixels');
      
      if (image.width != 1280 || image.height != 320) {
        print('   ❌ Dimension validation failed: Expected 1280x320, Got ${image.width}x${image.height}');
        _showErrorDialog(context, 'Banner image size must be 1280x320 pixels.\nYour image: ${image.width}x${image.height}');
        return false;
      }
      
      print('   ✅ Banner validation passed');
      return true;
    } catch (e) {
      print('   ❌ Validation error: $e');
      _showErrorDialog(context, 'Error validating image: $e');
      return false;
    }
  }

  // Validate post image
  Future<bool> _validatePostImage(String imagePath, BuildContext context) async {
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
            'Post image MUST be exactly 1080x1080 pixels\n\nYour image: ${image.width}x${image.height} pixels\nRequired: 1080x1080 pixels'
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
          content: Text(
            message,
            style: AppTextStyles.searchtext(context),
          ),
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

  void _addTag() {
    if (_tagController.text.trim().isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text.trim());
        _tagController.clear();
      });
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  void _submitForm() async {
    final imageState = context.read<ImagePickerBloc>().state;
    
    // Validate store name
    if (_storeNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter store name')),
      );
      return;
    }

    print('\n🚀 ===== SUBMITTING FORM DATA =====');
    print('📝 Store Name: ${_storeNameController.text.trim()}');
    print('🏷️ Tags: $_tags');

    // Get profile image
    String? profileImagePath = imageState.images['profile_image'];
    File? storeImage = profileImagePath != null ? File(profileImagePath) : null;
    
    if (storeImage != null) {
      print('\n👤 Profile Image:');
      print('   Path: $profileImagePath');
      await _logImageDimensions(storeImage, 'Profile');
    }

    // Get banner images and their IDs (if updating existing banners)
    List<File> bannerImages = [];
    List<int> bannerIds = [];
    
    // Sort banner keys to maintain order
    List<String> sortedBannerKeys = imageState.images.keys
        .where((key) => key.startsWith('banner_image_'))
        .toList()
      ..sort();
    
    print('\n🎨 Banner Images (${sortedBannerKeys.length}):');
    for (int i = 0; i < sortedBannerKeys.length; i++) {
      String key = sortedBannerKeys[i];
      String path = imageState.images[key]!;
      File bannerFile = File(path);
      bannerImages.add(bannerFile);
      print('   [$i] Key: $key');
      print('       Path: $path');
      await _logImageDimensions(bannerFile, 'Banner $i');
    }

    // Get post images
    List<File> postImages = [];
    print('\n📸 Post Images:');
    for (int i = 0; i < 2; i++) {
      String? postPath = imageState.images['post_image_$i'];
      if (postPath != null) {
        File postFile = File(postPath);
        postImages.add(postFile);
        print('   [$i] Path: $postPath');
        await _logImageDimensions(postFile, 'Post $i');
      }
    }

    print('\n✅ Total Images: ${(storeImage != null ? 1 : 0) + bannerImages.length + postImages.length}');
    print('📤 Sending to API:');
    print('   - storeName: ${_storeNameController.text.trim()}');
    print('   - storeTags: $_tags');
    print('   - storeImage: ${storeImage != null ? "YES" : "NO"}');
    print('   - bannerImages: ${bannerImages.length} files');
    print('   - postImages: ${postImages.length} files');
    print('================================\n');

    // Dispatch the update event
    context.read<StoreBloc>().add(
      UpdateStoreEvent(
        storeName: _storeNameController.text.trim(),
        storeTags: _tags,
        storeImage: storeImage,
        bannerImages: bannerImages.isNotEmpty ? bannerImages : null,
        bannerIds: null, // Will be null for new banners
        postImages: postImages.isNotEmpty ? postImages : null,
      ),
    );
  }

  // Helper method to log image dimensions
  Future<void> _logImageDimensions(File imageFile, String imageType) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image != null) {
        final sizeInKB = bytes.length / 1024;
        print('       Size: ${sizeInKB.toStringAsFixed(2)} KB');
        print('       Dimensions: ${image.width}x${image.height} pixels');
      }
    } catch (e) {
      print('       ❌ Failed to read dimensions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        title: AppStrings.editprofile,
        previousPageTitle: "Back",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.widthPct(17 / 375),
            right: context.widthPct(17 / 375),
            top: context.heightPct(14 / 812),
            bottom: context.heightPct(20 / 812),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section with Image Picker
              SizedBox(
                height: context.heightPct(127 / 812),
                child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, state) {
                    String? coverImagePath;
                    String? profileImagePath;
                    
                    if (state is ImagePicked) {
                      coverImagePath = state.images['cover_image'];
                      profileImagePath = state.images['profile_image'];
                    } else if (state is ImageInitial) {
                      coverImagePath = state.images['cover_image'];
                      profileImagePath = state.images['profile_image'];
                    }

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Cover Image
                        GestureDetector(
                          onTap: () {
                            context.read<ImagePickerBloc>().add(
                              PickImageEvent('cover_image'),
                            );
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: context.heightPct(90 / 812),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              border: Border.all(color: AppColors.stroke, width: 0.3),
                              gradient: coverImagePath == null
                                  ? LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [AppColors.primaryColor, AppColors.yellow],
                                    )
                                  : null,
                            ),
                            child: coverImagePath != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                    child: Image.file(
                                      File(coverImagePath),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        // Profile Picture
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                context.read<ImagePickerBloc>().add(
                                  PickImageEvent('profile_image'),
                                );
                              },
                              child: Container(
                                width: context.widthPct(74 / 375),
                                height: context.heightPct(74 / 812),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.stroke, width: 1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipOval(
                                  child: profileImagePath != null
                                      ? Image.file(
                                          File(profileImagePath),
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_outlined,
                                                color: AppColors.primaryColor,
                                                size: context.widthPct(24 / 375),
                                              ),
                                              SizedBox(height: context.heightPct(2 / 812)),
                                              Text(
                                                'Upload',
                                                style: AppTextStyles.searchtext(context).copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontSize: context.widthPct(10 / 375),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: context.heightPct(15 / 812)),
              
              // Store Name
              Text(
                AppStrings.storename,
                style: AppTextStyles.bodyRegular(context),
              ),
              ReusableTextField(
                controller: _storeNameController,
                hintText: AppStrings.enterhere,
                labelText: '',
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              
              // Tags
              Text(
                AppStrings.tags,
                style: AppTextStyles.bodyRegular(context),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        controller: _tagController,
                        hintText: AppStrings.enterhere,
                        labelText: '',
                      ),
                    ),
                    GestureDetector(
                      onTap: _addTag,
                      child: Container(
                        height: 46,
                        width: 43,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          border: Border.all(color: AppColors.stroke, width: 1),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Icon(Icons.add, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Display added tags
              if (_tags.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: context.heightPct(8 / 812)),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.asMap().entries.map((entry) {
                      return Chip(
                        label: Text(entry.value),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _removeTag(entry.key),
                        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      );
                    }).toList(),
                  ),
                ),
              
              SizedBox(height: context.heightPct(12 / 812)),
              
              // Banner Images
              Text(AppStrings.banner, style: AppTextStyles.bodyRegular(context)),
              Text(AppStrings.max2mb, style: AppTextStyles.searchtext(context)),
              SizedBox(height: context.heightPct(8 / 812)),
              
              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, state) {
                  Map<String, String> allImages = {};
                  
                  if (state is ImagePicked) {
                    allImages = state.images;
                  } else if (state is ImageInitial) {
                    allImages = state.images;
                  }

                  List<MapEntry<String, String>> bannerImages = allImages.entries
                      .where((entry) => entry.key.startsWith('banner_image_'))
                      .toList();

                  return Column(
                    children: [
                      if (bannerImages.isNotEmpty)
                        GridView.builder(
                          itemCount: bannerImages.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: context.widthPct(15 / 375),
                            mainAxisSpacing: context.heightPct(15 / 812),
                            childAspectRatio: 16 / 9,
                          ),
                          itemBuilder: (context, index) {
                            final bannerEntry = bannerImages[index];
                            final bannerKey = bannerEntry.key;
                            final bannerPath = bannerEntry.value;

                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColors.stroke,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      File(bannerPath),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<ImagePickerBloc>().add(
                                        RemoveImageEvent(bannerKey),
                                      );
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      
                      if (bannerImages.isNotEmpty)
                        SizedBox(height: context.heightPct(15 / 812)),
                      
                      GestureDetector(
                        onTap: () async {
                          int nextIndex = 0;
                          while (allImages.containsKey('banner_image_$nextIndex')) {
                            nextIndex++;
                          }
                          
                          String newBannerKey = 'banner_image_$nextIndex';
                          
                          context.read<ImagePickerBloc>().add(
                            PickImageEvent(newBannerKey),
                          );
                          
                          await Future.delayed(const Duration(milliseconds: 500));
                          final updatedState = context.read<ImagePickerBloc>().state;
                          
                          if (updatedState is ImagePicked) {
                            final imagePath = updatedState.images[newBannerKey];
                            if (imagePath != null && imagePath.isNotEmpty) {
                              final isValid = await _validateBannerImage(imagePath, context);
                              if (!isValid) {
                                context.read<ImagePickerBloc>().add(
                                  RemoveImageEvent(newBannerKey),
                                );
                              }
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: context.heightPct(120 / 812),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.primaryColor,
                                  size: context.widthPct(32 / 375),
                                ),
                                SizedBox(height: context.heightPct(5 / 812)),
                                Text(
                                  'Add Banner',
                                  style: AppTextStyles.searchtext(context).copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(height: context.heightPct(3 / 812)),
                                Text(
                                  '1280x320 pixels, Max 2MB',
                                  style: AppTextStyles.searchtext(context).copyWith(
                                    fontSize: context.widthPct(10 / 375),
                                  ),
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
              
              SizedBox(height: context.heightPct(12 / 812)),
              
              // Post Images
              Text(AppStrings.post, style: AppTextStyles.bodyRegular(context)),
              Text(AppStrings.eachpost, style: AppTextStyles.searchtext(context)),
              SizedBox(height: context.heightPct(8 / 812)),
              
              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, state) {
                  Map<String, String> postImages = {};
                  
                  if (state is ImagePicked) {
                    postImages = state.images;
                  } else if (state is ImageInitial) {
                    postImages = state.images;
                  }

                  return GridView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.widthPct(15 / 375),
                      mainAxisSpacing: context.heightPct(15 / 812),
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      String postKey = 'post_image_$index';
                      String? postImagePath = postImages[postKey];

                      return GestureDetector(
                        onTap: () async {
                          context.read<ImagePickerBloc>().add(
                            PickImageEvent(postKey),
                          );
                          
                          await Future.delayed(const Duration(milliseconds: 500));
                          final updatedState = context.read<ImagePickerBloc>().state;
                          
                          if (updatedState is ImagePicked) {
                            final imagePath = updatedState.images[postKey];
                            if (imagePath != null && imagePath.isNotEmpty) {
                              final isValid = await _validatePostImage(imagePath, context);
                              if (!isValid) {
                                context.read<ImagePickerBloc>().add(
                                  RemoveImageEvent(postKey),
                                );
                              }
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: AppColors.stroke,
                              width: 1,
                            ),
                          ),
                          child: postImagePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(
                                    File(postImagePath),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        color: AppColors.primaryColor,
                                        size: context.widthPct(32 / 375),
                                      ),
                                      SizedBox(height: context.heightPct(5 / 812)),
                                      Text(
                                        'Upload',
                                        style: AppTextStyles.searchtext(context).copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: context.heightPct(2 / 812)),
                                      Text(
                                        '1080x270',
                                        style: AppTextStyles.searchtext(context).copyWith(
                                          fontSize: context.widthPct(9 / 375),
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
              
              SizedBox(height: context.heightPct(23 / 812)),
              
              // Submit Button
              BlocConsumer<StoreBloc, StoreUpdateState>(
                listener: (context, state) {
                  if (state.status == StoreUpdateStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message ?? "Store updated successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Navigate or refresh as needed
                  } else if (state.status == StoreUpdateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message ?? "Something went wrong",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ReusableButton(
                    text: state.status == StoreUpdateStatus.loading
                        ? "Submitting..."
                        : "Done",
                    onPressed: state.status == StoreUpdateStatus.loading
                        ? () {}
                        : _submitForm,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}