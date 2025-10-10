import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
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
  final bool isVideo;

  const ReusableImageContainer({
    super.key,
    required this.placeholderSvg,
    required this.imageKey,
    this.widthFactor = 0.9,
    this.heightFactor = 0.25,
    this.fit = BoxFit.cover,
    this.isVideo = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePickerError) {
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
        String? mediaPath;
        if (state is ImagePicked) {
          mediaPath = state.images[imageKey];
        } else if (state is ImageInitial) {
          mediaPath = state.images[imageKey];
        } else if (state is ImagePickerError) {
          mediaPath = state.images[imageKey];
        }

        return GestureDetector(
          onTap: () {
            if (isVideo) {
              context.read<ImagePickerBloc>().add(PickVideoEvent(imageKey));
            } else {
              context.read<ImagePickerBloc>().add(PickImageEvent(imageKey));
            }
          },
          child: Container(
            width: context.widthPct(widthFactor!),
            height: context.heightPct(heightFactor!),
            padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.005)),
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
              child: Center(child: _buildMedia(mediaPath)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedia(String? mediaPath) {
    if (mediaPath != null && mediaPath.isNotEmpty) {
      if (isVideo) {
        // Display video player with unique key to prevent multiple instances
        return VideoPlayerWidget(
          key: ValueKey(mediaPath), // Unique key prevents duplicate players
          videoPath: mediaPath,
          fit: fit,
        );
      } else {
        // Display image
        return Image.file(File(mediaPath), fit: fit);
      }
    } else {
      // Display placeholder
      return SvgPicture.asset(placeholderSvg, fit: BoxFit.contain);
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final BoxFit fit;

  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
    this.fit = BoxFit.cover,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? controller;
  bool isInitialized = false;
  bool showPlayer = false;

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      controller?.dispose();
      controller = null;
      isInitialized = false;
      showPlayer = false;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  Future<void> initializeAndPlay() async {
    if (controller != null) {
      setState(() {
        if (controller!.value.isPlaying) {
          controller!.pause();
        } else {
          controller!.play();
        }
      });
      return;
    }

    setState(() {
      showPlayer = true;
    });

    controller = VideoPlayerController.file(File(widget.videoPath));
    try {
      await controller!.initialize();
      if (mounted) {
        setState(() {
          isInitialized = true;
        });
        controller!.setLooping(true);
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      if (mounted) {
        setState(() {
          showPlayer = false;
          isInitialized = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showPlayer) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black87,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_circle_filled, color: Colors.white, size: 64),
                  SizedBox(height: 8),
                  Text(
                    'Tap to play video',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: initializeAndPlay),
            ),
          ),
        ],
      );
    }

    if (!isInitialized) {
      return Container(
        color: Colors.black87,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return GestureDetector(
      onTap: initializeAndPlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
              ),
            ),
          ),
          if (!controller!.value.isPlaying)
            const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 64,
            ),
        ],
      ),
    );
  }
}
