import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hibuy/res/assets/image_assets.dart';
import 'package:video_player/video_player.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_bloc.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_event.dart';
import 'package:hibuy/Bloc/image_picker/image_picker_state.dart';
import 'package:hibuy/res/media_querry/media_query.dart';
import 'package:hibuy/res/colors/app_color.dart';
import 'package:hibuy/res/text_style.dart';

class VideoWidget extends StatefulWidget {
  final String? networkVideoUrl;
  final String videoKey;
  final double? widthFactor;
  final double? heightFactor;
  final String placeholderSvg;

  const VideoWidget({
    super.key,
    this.networkVideoUrl,
    required this.videoKey,
    this.widthFactor,
    this.heightFactor,
    required this.placeholderSvg,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.networkVideoUrl != widget.networkVideoUrl) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isInitialized = false;
    });

    try {
      // Check if we have a network video URL
      if (widget.networkVideoUrl != null &&
          widget.networkVideoUrl!.isNotEmpty) {
        print('🎥 Initializing network video: ${widget.networkVideoUrl}');

        // Validate URL format
        final uri = Uri.tryParse(widget.networkVideoUrl!);
        if (uri == null ||
            (!uri.hasScheme || (!uri.scheme.startsWith('http')))) {
          print('❌ Invalid video URL format: ${widget.networkVideoUrl}');
          setState(() {
            _isLoading = false;
            _errorMessage = 'Invalid video URL format';
          });
          return;
        }

        print('✅ Valid URL format, creating controller for: $uri');
        _controller = VideoPlayerController.networkUrl(
          uri,
          videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: false,
            allowBackgroundPlayback: false,
          ),
        );
      } else {
        // Check if we have a local video file from image picker
        final imagePickerState = context.read<ImagePickerBloc>().state;
        final localVideoPath = imagePickerState.images[widget.videoKey];

        if (localVideoPath != null && localVideoPath.isNotEmpty) {
          final file = File(localVideoPath);
          if (!file.existsSync()) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Video file not found';
            });
            return;
          }
          _controller = VideoPlayerController.file(
            file,
            videoPlayerOptions: VideoPlayerOptions(
              mixWithOthers: false,
              allowBackgroundPlayback: false,
            ),
          );
        } else {
          // No video available
          setState(() {
            _isLoading = false;
            _errorMessage = 'No video available';
          });
          return;
        }
      }

      // Add error listener
      _controller!.addListener(_videoListener);

      print('🔄 Initializing video controller...');
      await _controller!.initialize();
      print('✅ Video controller initialized successfully');

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
        print('🎬 Video widget ready to play');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load video: ${e.toString()}';
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null && mounted) {
      if (_controller!.value.hasError) {
        print('❌ Video playback error: ${_controller!.value.errorDescription}');
        setState(() {
          _isInitialized = false;
          _errorMessage =
              'Video playback error: ${_controller!.value.errorDescription}';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  void _pickVideo() {
    context.read<ImagePickerBloc>().add(PickVideoEvent(widget.videoKey));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePicked && state.images.containsKey(widget.videoKey)) {
          // Video was picked, reinitialize
          _initializeVideo();
        }
      },
      child: Container(
        width: widget.widthFactor != null
            ? MediaQuery.of(context).size.width * widget.widthFactor!
            : MediaQuery.of(context).size.width * 0.9,
        height: widget.heightFactor != null
            ? MediaQuery.of(context).size.height * widget.heightFactor!
            : MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          // color: AppColors.gray,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.stroke),
        ),
        child: _buildVideoContent(context),
      ),
    );
  }

  Widget _buildVideoContent(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return _buildErrorState(context);
    }

    if (!_isInitialized || _controller == null) {
      return _buildNoVideoState(context);
    }

    return _buildVideoPlayer(context);
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ),
        Center(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
              });
            },
            backgroundColor: AppColors.primaryColor.withOpacity(0.8),
            child: Icon(
              _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppColors.white,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatDuration(_controller!.value.position) +
                  ' / ' +
                  _formatDuration(_controller!.value.duration),
              style: AppTextStyles.samibold(
                context,
              ).copyWith(color: AppColors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    // Get the video file info if available
    final imagePickerState = context.read<ImagePickerBloc>().state;
    final videoPath = imagePickerState.images[widget.videoKey];
    String? fileType;
    String? fileName;

    if (videoPath != null && videoPath.isNotEmpty) {
      final file = File(videoPath);
      fileName = file.path.split('/').last;
      final extension = fileName.split('.').last.toLowerCase();
      fileType = 'Video (.$extension)';
    }

    return GestureDetector(
      onTap: _pickVideo,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.videoUpload, width: 20, height: 20),
            Text(
              "Video",
              style: TextStyle(
                fontSize: context.scaledFont(20),
                color: AppColors.primaryColor,
              ),
            ),
            if (fileType != null) ...[
              SizedBox(height: context.heightPct(0.01)),
              Text(
                fileType,
                style: AppTextStyles.medium(context),
                textAlign: TextAlign.center,
              ),
              if (fileName != null) ...[
                SizedBox(height: context.heightPct(0.005)),
                Text(
                  fileName,
                  style: AppTextStyles.regular(context),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
            // if (_errorMessage != null && _errorMessage!.isNotEmpty) ...[
            //   SizedBox(height: context.heightPct(0.01)),
            //   Padding(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: context.widthPct(0.05),
            //     ),
            //     child: Text(
            //       _errorMessage!,
            //       style: AppTextStyles.bodyRegular(context),
            //       textAlign: TextAlign.center,
            //     ),
            // ),
            // ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoVideoState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videocam_outlined, color: AppColors.gray2, size: 48),
          SizedBox(height: context.heightPct(0.01)),
          // Text('No video available', style: AppTextStyles.bodyRegular(context)),
          // SizedBox(height: context.heightPct(0.01)),
          ElevatedButton(
            onPressed: _pickVideo,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Pick Video'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
