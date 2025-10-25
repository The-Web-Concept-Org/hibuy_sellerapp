import 'package:flutter/material.dart';
import 'package:hibuy/res/colors/app_color.dart';

class FullScreenImageViewer extends StatefulWidget {
  final String imageUrl;
  final String? title;

  const FullScreenImageViewer({super.key, required this.imageUrl, this.title});

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title ?? 'Invoice',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(child: _buildImage()),
    );
  }

  Widget _buildImage() {
    return Image.network(
      widget.imageUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Failed to load image',
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
