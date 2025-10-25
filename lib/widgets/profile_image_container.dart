import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class ProfileImageContainer extends StatefulWidget {
  final String networkImageUrl;
  final Function(File?) onImagePicked;
  final String imageKey;
  final double? width;
  final double? height;
  final Uint8List? profileImageBytes;

  const ProfileImageContainer({
    super.key,
    required this.networkImageUrl,
    required this.onImagePicked,
    this.imageKey = 'profile',
    this.width,
    this.height,
    this.profileImageBytes,
  });

  @override
  State<ProfileImageContainer> createState() => _ProfileImageContainerState();
}

class _ProfileImageContainerState extends State<ProfileImageContainer> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final double containerWidth = widget.width ?? context.widthPct(64 / 375);
    final double containerHeight = widget.height ?? context.heightPct(64 / 812);

    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePicked) {
          final imagePath = state.images[widget.imageKey];
          if (imagePath != null && imagePath.isNotEmpty) {
            setState(() {
              _pickedImage = File(imagePath);
            });
            widget.onImagePicked(_pickedImage);
          }
        } else if (state is ImagePickerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ImagePickerBloc>().add(
              PickImageEvent(widget.imageKey),
            );
          },
          child: Container(
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
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    // Priority 1: If user has picked a new file locally, show it
    if (_pickedImage != null && _pickedImage!.existsSync()) {
      return Image.file(
        _pickedImage!,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Priority 2: If we have Uint8List from memory (stored in Hive), show it
    if (widget.profileImageBytes != null &&
        widget.profileImageBytes!.isNotEmpty) {
      return Image.memory(
        widget.profileImageBytes!,
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // Priority 3: If no local file and network URL exists, show network image
    if (widget.networkImageUrl.isNotEmpty) {
      return Image.network(
        widget.networkImageUrl,
        fit: BoxFit.fill,
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
