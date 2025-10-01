import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class ReusableCircleImage extends StatelessWidget {
  final String placeholderSvg;  
  final String imageKey;         
  final double? sizeFactor;    
  final BoxFit fit;

  const ReusableCircleImage({
    super.key,
    required this.imageKey,
    required this.placeholderSvg,
    this.sizeFactor = 0.28,
    this.fit = BoxFit.cover,
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

        return GestureDetector(
          onTap: () {
            context.read<ImagePickerBloc>().add(PickImageEvent(imageKey));
          },
          child: Container(
            width: size,
            height: size,
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(0.005),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFB4B4B4),
                width: context.widthPct(0.001),
              ),
            ),
            child: ClipOval(
              child: Center(
                child: _buildImage(imagePath),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.file(
        File(imagePath), 
        fit: fit,
      );
    } else {
      return SvgPicture.asset(
        placeholderSvg, 
        fit: BoxFit.contain,
      );
    }
  }
}
