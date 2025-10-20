import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';

class ReusableCircleImage extends StatelessWidget {
  final String placeholderSvg;
  final String imageKey;
  final double? sizeFactor;
  final BoxFit fit;
  final String? networkImageUrl; // ✅ Network image URL from API

  const ReusableCircleImage({
    super.key,
    required this.imageKey,
    required this.placeholderSvg,
    this.sizeFactor = 0.28,
    this.fit = BoxFit.cover,
    this.networkImageUrl, // ✅ Optional network URL
  });

  @override
  Widget build(BuildContext context) {
    final double size = context.widthPct(sizeFactor!);

    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        String? imagePath;
        if (state is ImagePicked) {
          imagePath = state.images[imageKey];
        } else if (state is ImageInitial) {
          imagePath = state.images[imageKey];
        }

        // ✅ Get AuthState to check for network images
        final authState = context.watch<AuthBloc>().state;

        return GestureDetector(
          onTap: () {
            context.read<ImagePickerBloc>().add(PickImageEvent(imageKey));
          },
          child: Container(
            width: size,
            height: size,
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.005)),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFB4B4B4),
                width: context.widthPct(0.001),
              ),
            ),
            child: ClipOval(
              child: Center(child: _buildImage(context, authState, imagePath)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(
    BuildContext context,
    AuthState authState,
    String? imagePath,
  ) {
    // ✅ Priority: 1. Local file (newly picked), 2. Network URL (from API), 3. Placeholder

    // If user has picked a new file locally, show it
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.file(File(imagePath), fit: fit);
    }

    // ✅ Check if File variable is null to determine if we should show network image
    // This ensures network image only shows when no local file exists in AuthState
    final bool shouldShowNetworkImage = _shouldShowNetworkImage(
      authState,
      imageKey,
    );

    // If in edit mode, File is null, and network URL exists, show network image
    if (authState.isEditMode &&
        shouldShowNetworkImage &&
        networkImageUrl != null &&
        networkImageUrl!.isNotEmpty) {
      // ✅ Construct full URL (assuming base URL is needed)
      final String fullUrl = networkImageUrl!.startsWith('http')
          ? networkImageUrl!
          : 'https://dashboard.hibuyo.com/$networkImageUrl';

      return Image.network(
        fullUrl,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error_outline, color: Colors.red, size: 30);
        },
      );
    }

    // Show placeholder if no image
    return SvgPicture.asset(placeholderSvg, fit: BoxFit.contain);
  }

  /// ✅ Helper method to check if File variable is null for the given image key
  /// Returns true if the File is null (meaning no new image has been picked)
  bool _shouldShowNetworkImage(AuthState authState, String imageKey) {
    switch (imageKey) {
      // Personal Info
      case 'personal':
        return authState.personalProfilePicture == null;

      // Store Info
      case 'store':
        return authState.storeProfilePicture == null;

      // Business Info
      case 'business':
        return authState.businessPersonalProfile == null;

      default:
        return true; // For unknown keys, allow network image
    }
  }
}
