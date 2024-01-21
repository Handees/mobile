import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/image_upload/data/image_upload.model.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageStateNotifier, ImageUploadModel>(
        (ref) => ImageStateNotifier());

class ImageStateNotifier extends StateNotifier<ImageUploadModel> {
  ImageStateNotifier() : super(ImageUploadModel.empty());

  void updateSelectedImage(File selectedImage) {
    state = state.copyWith(selectedImage: selectedImage);
  }

  void updateImageUploadStream(Stream<TaskSnapshot?>? imageUploadStream) {
    state = state.copyWith(
      imageUploadStream: imageUploadStream,
      forceImageUploadStream: true,
    );
  }

  void updateIsImageUploading(bool isImageUploading) {
    state = state.copyWith(isImageUploading: isImageUploading);
  }

  void updateFileType(String fileType) {
    state = state.copyWith(fileType: fileType);
  }
}
