import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/media_querry/media_query.dart';

class ReusableImageContainer extends StatelessWidget {
  final String placeholderSvg;   
  final String imageKey;        
  final double? widthFactor;     
  final double? heightFactor;    
  final BoxFit fit;

  const ReusableImageContainer({
    super.key,
    required this.placeholderSvg,
    required this.imageKey,       
    this.widthFactor = 0.9,
    this.heightFactor = 0.25,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        String? imagePath;
        if (state is ImagePicked) {
          imagePath = state.images[imageKey]; // 🔑 get specific image
        } else if (state is ImageInitial) {
          imagePath = state.images[imageKey];
        }

        return GestureDetector(
          onTap: () {
            context.read<ImagePickerBloc>().add(PickImageEvent(imageKey));
          },
          child: Container(
            width: context.widthPct(widthFactor!),
            height: context.heightPct(heightFactor!),
            padding: EdgeInsets.symmetric(
              horizontal: context.widthPct(0.005),
            ),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(context.widthPct(0.015)),
              border: Border.all(
                color: AppColors.bordercolor,
                width: context.widthPct(0.001),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.widthPct(0.015)),
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
