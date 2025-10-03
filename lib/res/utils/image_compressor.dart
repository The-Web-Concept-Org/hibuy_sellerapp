import 'dart:io';
import 'dart:developer';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressor {
  /// Compress image to be under 2048 KB (2 MB)
  static Future<File?> compressImage(File file) async {
    try {
      // Get file size in KB
      int fileSizeInBytes = await file.length();
      double fileSizeInKB = fileSizeInBytes / 1024;

      log('📷 Original image size: ${fileSizeInKB.toStringAsFixed(2)} KB');

      // If file is already under 2048 KB, return as is
      if (fileSizeInKB <= 2048) {
        log('✅ Image already under 2048 KB, no compression needed');
        return file;
      }

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final fileExtension = file.path.split('.').last;
      final targetPath =
          '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      // Start with quality 85
      int quality = 85;
      File? compressedFile;

      // Try compressing with decreasing quality until under 2048 KB
      while (quality >= 20) {
        log('🔄 Compressing with quality: $quality%');

        final result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: quality,
          format: CompressFormat.jpeg,
        );

        if (result != null) {
          compressedFile = File(result.path);
          final compressedSize = await compressedFile.length();
          final compressedSizeInKB = compressedSize / 1024;

          log(
            '📦 Compressed size: ${compressedSizeInKB.toStringAsFixed(2)} KB',
          );

          if (compressedSizeInKB <= 2048) {
            log(
              '✅ Successfully compressed to ${compressedSizeInKB.toStringAsFixed(2)} KB',
            );
            return compressedFile;
          }
        }

        // Reduce quality for next attempt
        quality -= 15;
      }

      // If still too large, try aggressive compression with smaller dimensions
      log('⚠️ Still too large, trying dimension reduction...');

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 50,
        minWidth: 1024,
        minHeight: 1024,
        format: CompressFormat.jpeg,
      );

      if (result != null) {
        compressedFile = File(result.path);
        final compressedSize = await compressedFile.length();
        final compressedSizeInKB = compressedSize / 1024;

        log(
          '📦 Final compressed size: ${compressedSizeInKB.toStringAsFixed(2)} KB',
        );

        if (compressedSizeInKB <= 2048) {
          log('✅ Successfully compressed with dimension reduction');
          return compressedFile;
        }
      }

      // Last resort: very aggressive compression
      log('⚠️ Applying maximum compression...');

      final lastResult = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 30,
        minWidth: 800,
        minHeight: 800,
        format: CompressFormat.jpeg,
      );

      if (lastResult != null) {
        compressedFile = File(lastResult.path);
        final compressedSize = await compressedFile.length();
        final compressedSizeInKB = compressedSize / 1024;

        log(
          '📦 Maximum compressed size: ${compressedSizeInKB.toStringAsFixed(2)} KB',
        );
        return compressedFile;
      }

      log('❌ Failed to compress image under 2048 KB');
      return null;
    } catch (e) {
      log('❌ Error compressing image: $e');
      return null;
    }
  }

  /// Get human-readable file size
  static String getFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
}
