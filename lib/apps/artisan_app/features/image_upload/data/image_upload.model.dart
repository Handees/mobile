import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadModel {
  final bool isImageUploading;
  final Stream<TaskSnapshot?>? imageUploadStream;
  final File? selectedImage;
  final String fileType;

  ImageUploadModel({
    required this.isImageUploading,
    required this.imageUploadStream,
    required this.selectedImage,
    required this.fileType,
  });

  ImageUploadModel.empty()
      : isImageUploading = false,
        imageUploadStream = null,
        selectedImage = null,
        fileType = '';

  ImageUploadModel copyWith({
    bool? isImageUploading,
    Stream<TaskSnapshot?>? imageUploadStream,
    File? selectedImage,
    String? fileType,
    bool forceImageUploadStream = false,
  }) {
    return ImageUploadModel(
      isImageUploading: isImageUploading ?? this.isImageUploading,
      imageUploadStream: forceImageUploadStream
          ? imageUploadStream
          : imageUploadStream ?? this.imageUploadStream,
      selectedImage: selectedImage ?? this.selectedImage,
      fileType: fileType ?? this.fileType,
    );
  }
}
