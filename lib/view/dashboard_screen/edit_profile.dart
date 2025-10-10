import 'dart:io';
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
import 'package:hibuy/widgets/profile_widget.dart/app_bar.dart';
import 'package:hibuy/widgets/profile_widget.dart/button.dart';
import 'package:hibuy/widgets/profile_widget.dart/text_field.dart';
import 'package:image/image.dart' as img;

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  // Validate banner image
  Future<bool> _validateBannerImage(String imagePath, BuildContext context) async {
    try {
      final file = File(imagePath);
      
      // Check file size (max 2MB)
      final fileSizeInBytes = await file.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      
      if (fileSizeInMB > 2) {
        _showErrorDialog(context, 'Banner image must be maximum 2MB');
        return false;
      }
      
      // Check image dimensions (1280x320)
      final imageBytes = await file.readAsBytes();
      final image = img.decodeImage(imageBytes);
      
      if (image == null) {
        _showErrorDialog(context, 'Invalid image file');
        return false;
      }
      
      if (image.width != 1280 || image.height != 320) {
        _showErrorDialog(context, 'Banner image size must be 1280x320 pixels');
        return false;
      }
      
      return true;
    } catch (e) {
      _showErrorDialog(context, 'Error validating image: $e');
      return false;
    }
  }

  // Validate post image
  Future<bool> _validatePostImage(String imagePath, BuildContext context) async {
    try {
      final file = File(imagePath);
      
      // Check image dimensions (1080x1080)
      final imageBytes = await file.readAsBytes();
      final image = img.decodeImage(imageBytes);
      
      if (image == null) {
        _showErrorDialog(context, 'Invalid image file');
        return false;
      }
      
      if (image.width != 1080 || image.height != 1080) {
        _showErrorDialog(context, 'Post image size must be 1080x1080 pixels');
        return false;
      }
      
      return true;
    } catch (e) {
      _showErrorDialog(context, 'Error validating image: $e');
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
              Text(
                AppStrings.storename,
                style: AppTextStyles.bodyRegular(context),
              ),
              ReusableTextField(
                hintText: AppStrings.enterhere,
                labelText: '',
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              Text(
                AppStrings.tags,
                style: AppTextStyles.bodyRegular(context),
              ),
              Row(
                children: [
                  Expanded(
                    child: ReusableTextField(
                      hintText: AppStrings.enterhere,
                      labelText: '',
                    ),
                  ),
                  Container(
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
                ],
              ),
              SizedBox(height: context.heightPct(12 / 812)),
              Text(AppStrings.banner, style: AppTextStyles.bodyRegular(context)),
              Text(AppStrings.max2mb, style: AppTextStyles.searchtext(context)),
              SizedBox(height: context.heightPct(8 / 812)),
              
              // Multiple Banner Images with Grid Layout
              BlocBuilder<ImagePickerBloc, ImagePickerState>(
                builder: (context, state) {
                  Map<String, String> allImages = {};
                  
                  if (state is ImagePicked) {
                    allImages = state.images;
                  } else if (state is ImageInitial) {
                    allImages = state.images;
                  }

                  // Filter banner images
                  List<MapEntry<String, String>> bannerImages = allImages.entries
                      .where((entry) => entry.key.startsWith('banner_image_'))
                      .toList();

                  return Column(
                    children: [
                      // Display existing banner images in grid
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
                                // Remove button
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
                      
                      // Add new banner button
                      GestureDetector(
                        onTap: () async {
                          // Find next available banner index
                          int nextIndex = 0;
                          while (allImages.containsKey('banner_image_$nextIndex')) {
                            nextIndex++;
                          }
                          
                          String newBannerKey = 'banner_image_$nextIndex';
                          
                          context.read<ImagePickerBloc>().add(
                            PickImageEvent(newBannerKey),
                          );
                          
                          // Wait for state update and validate
                          await Future.delayed(const Duration(milliseconds: 500));
                          final updatedState = context.read<ImagePickerBloc>().state;
                          
                          if (updatedState is ImagePicked) {
                            final imagePath = updatedState.images[newBannerKey];
                            if (imagePath != null && imagePath.isNotEmpty) {
                              final isValid = await _validateBannerImage(imagePath, context);
                              if (!isValid) {
                                // Remove invalid image
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
              Text(AppStrings.post, style: AppTextStyles.bodyRegular(context)),
              Text(AppStrings.eachpost, style: AppTextStyles.searchtext(context)),
              SizedBox(height: context.heightPct(8 / 812)),
              
              // Post Images with Image Picker and Validation
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
                          
                          // Wait for state update and validate
                          await Future.delayed(const Duration(milliseconds: 500));
                          final updatedState = context.read<ImagePickerBloc>().state;
                          
                          if (updatedState is ImagePicked) {
                            final imagePath = updatedState.images[postKey];
                            if (imagePath != null && imagePath.isNotEmpty) {
                              final isValid = await _validatePostImage(imagePath, context);
                              if (!isValid) {
                                // Remove invalid image
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
                                        '1080x1080',
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
              ReusableButton(
                text: AppStrings.done,
                onPressed: () {
                  // Handle form submission
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}