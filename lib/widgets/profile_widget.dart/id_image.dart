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
import 'package:hibuy/view/auth/bloc/auth_bloc.dart';
import 'package:hibuy/view/auth/bloc/auth_state.dart';

class ReusableImageContainer extends StatelessWidget {
  final String placeholderSvg;
  final String imageKey;
  final double? widthFactor;
  final double? heightFactor;
  final BoxFit fit;
  final bool isVideo;
  final bool autoPlayOnReturn;
  final String? networkImageUrl; // ✅ Network image URL from API

  const ReusableImageContainer({
    super.key,
    required this.placeholderSvg,
    required this.imageKey,
    this.widthFactor = 0.9,
    this.heightFactor = 0.25,
    this.fit = BoxFit.cover,
    this.isVideo = false,
    this.autoPlayOnReturn = false,
    this.networkImageUrl, // ✅ Optional network URL
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

        // ✅ Get AuthState to check for network images
        final authState = context.watch<AuthBloc>().state;

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
              child: Center(child: _buildMedia(context, authState, mediaPath)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMedia(
    BuildContext context,
    AuthState authState,
    String? mediaPath,
  ) {
    // ✅ Priority: 1. Local file (newly picked), 2. Network URL (from API), 3. Placeholder

    // If user has picked a new file locally, show it
    if (mediaPath != null && mediaPath.isNotEmpty) {
      if (isVideo) {
        // Display video player with unique key to prevent multiple instances
        return VideoPlayerWidget(
          key: ValueKey(mediaPath), // Unique key prevents duplicate players
          videoPath: mediaPath,
          fit: fit,
          autoPlayOnReturn: autoPlayOnReturn,
          isNetworkVideo: false,
        );
      } else {
        // Display local image
        return Image.file(File(mediaPath), fit: fit);
      }
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
          : 'https://dashboard.hibuyo.com/$networkImageUrl'; // ✅ Add your base URL

      if (isVideo) {
        return VideoPlayerWidget(
          key: ValueKey(fullUrl),
          videoPath: fullUrl,
          fit: fit,
          autoPlayOnReturn: autoPlayOnReturn,
          isNetworkVideo: true,
        );
      } else {
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40),
                SizedBox(height: 8),
                Text('Failed to load image', style: TextStyle(fontSize: 12)),
              ],
            );
          },
        );
      }
    }
    // Show placeholder if no image
    else {
      // Display placeholder
      return SvgPicture.asset(placeholderSvg, fit: BoxFit.contain);
    }
  }

  /// ✅ Helper method to check if File variable is null for the given image key
  /// Returns true if the File is null (meaning no new image has been picked)
  bool _shouldShowNetworkImage(AuthState authState, String imageKey) {
    switch (imageKey) {
      // Personal Info
      case 'cnicFrontImage':
        return authState.personalFrontImage == null;
      case 'cnicBackImage':
        return authState.personalBackImage == null;

      // Documents
      case 'profileimage': // Home bill
        return authState.documentsHomeBill == null;
      case 'shopVideo':
        return authState.documentsShopVideo == null;

      // Bank
      case 'cheque':
        return authState.bankCanceledCheque == null;
      case 'verification':
        return authState.bankVerificationLetter == null;

      // Business
      case 'leter': // Letter head
        return authState.businessLetterHead == null;
      case 'stamp':
        return authState.businessStamp == null;

      default:
        return true; // For unknown keys, allow network image
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final BoxFit fit;
  final bool autoPlayOnReturn;
  final bool isNetworkVideo; // ✅ Flag to differentiate network vs local video

  const VideoPlayerWidget({
    super.key,
    required this.videoPath,
    this.fit = BoxFit.cover,
    this.autoPlayOnReturn = true,
    this.isNetworkVideo = false, // ✅ Default to local video
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? controller;
  bool isInitialized = false;
  bool showPlayer = false;

  @override
  void initState() {
    super.initState();
    // Auto-initialize and play if autoPlayOnReturn is true
    if (widget.autoPlayOnReturn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initializeAndPlay();
      });
    }
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      controller?.dispose();
      controller = null;
      isInitialized = false;
      showPlayer = false;
      // Auto-play on path change if enabled
      if (widget.autoPlayOnReturn) {
        initializeAndPlay();
      }
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

    // ✅ Use network or file controller based on flag
    controller = widget.isNetworkVideo
        ? VideoPlayerController.network(widget.videoPath)
        : VideoPlayerController.file(File(widget.videoPath));

    try {
      await controller!.initialize();
      if (mounted) {
        setState(() {
          isInitialized = true;
        });
        controller!.setLooping(true);
        // Auto-play if enabled
        if (widget.autoPlayOnReturn) {
          controller!.play();
        }
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
