import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class UpdateStoreEvent extends StoreEvent {
  final String storeName;
  final List<String> storeTags;
  final File? storeImage;
  final List<File>? bannerImages;
  final List<int>? bannerIds; // Add this for updating existing banners
  final List<File>? postImages;

  const UpdateStoreEvent({
    required this.storeName,
    required this.storeTags,
    this.storeImage,
    this.bannerImages,
    this.bannerIds,
    this.postImages,
  });

  @override
  List<Object?> get props => [
        storeName,
        storeTags,
        storeImage,
        bannerImages,
        bannerIds,
        postImages,
      ];
}