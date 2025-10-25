import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class ProfileImageDisplay extends StatelessWidget {
  final String? networkImageUrl;
  final Uint8List? profileImageBytes;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProfileImageDisplay({
    super.key,
    this.networkImageUrl,
    this.profileImageBytes,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    final double containerWidth = width ?? context.widthPct(64 / 375);
    final double containerHeight = height ?? context.heightPct(64 / 812);

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2.85),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    // Priority 1: If we have Uint8List from memory (stored in Hive), show it
    if (profileImageBytes != null && profileImageBytes!.isNotEmpty) {
      return Image.memory(
        profileImageBytes!,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Priority 2: If network URL exists, show network image
    if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      return Image.network(
        networkImageUrl!,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
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
          return Container(
            color: AppColors.gray,
            child: const Icon(Icons.person, color: Colors.grey, size: 40),
          );
        },
      );
    }

    // Show placeholder if no image
    return Container(
      color: AppColors.gray,
      child: const Icon(Icons.person, color: Colors.grey, size: 40),
    );
  }
}
