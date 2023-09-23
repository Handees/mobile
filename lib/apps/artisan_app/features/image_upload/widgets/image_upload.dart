import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/image_upload/providers/image_upload.provider.dart';
import 'package:handees/apps/customer_app/services/storage_service.customer.dart';
import 'package:handees/shared/ui/widgets/custom_bottom_sheet.dart';
import 'package:handees/shared/utils/extensions.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends ConsumerWidget {
  final String? fileType;
  final String uploadedImageUrl;
  final String storagePath;
  final Function(String) updateImageUrl;
  ImageUpload({
    this.fileType,
    required this.uploadedImageUrl,
    required this.updateImageUrl,
    required this.storagePath,
    super.key,
  });

  final ImagePicker _picker = ImagePicker();

  void updateImageUploadProvider(XFile? image, WidgetRef ref) {
    if (image != null) {
      final imageUploadStream =
          ref.watch(storageServiceProvider).getImageUploadStream(
                file: File(image.path),
                filePath: storagePath,
              );

      ref.read(imageUploadProvider.notifier).updateIsImageUploading(true);

      ref
          .read(imageUploadProvider.notifier)
          .updateSelectedImage(File(image.path));
      ref
          .read(imageUploadProvider.notifier)
          .updateImageUploadStream(imageUploadStream);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUploader = ref.watch(imageUploadProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              XFile? image;
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomBottomSheet(
                      title: 'Select Image Source',
                      text: '',
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton.filled(
                            padding: const EdgeInsets.all(20),
                            color: Colors.black,
                            onPressed: () async {
                              Navigator.of(context).pop();
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              updateImageUploadProvider(image, ref);
                            },
                            icon: const Icon(
                              Icons.collections,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          IconButton.filled(
                            padding: const EdgeInsets.all(20),
                            color: Colors.black,
                            onPressed: () async {
                              Navigator.of(context).pop();
                              image = await _picker.pickImage(
                                  source: ImageSource.camera);

                              updateImageUploadProvider(image, ref);
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: uploadedImageUrl.isNotEmpty
                    ? DecorationImage(
                        image: FileImage(imageUploader.selectedImage!),
                        fit: BoxFit.contain,
                      )
                    : null,
                border: Border.all(
                  color: const Color(0xff949494),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: uploadedImageUrl.isNotEmpty
                  ? null
                  : imageUploader.isImageUploading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload,
                                size: 50,
                                color: Color(0xffa8dadc),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                "Upload your ${fileType ?? imageUploader.fileType} here (PNG, JPG)",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff949494),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
          const SizedBox(height: 16.0),
          if (imageUploader.imageUploadStream != null)
            StreamBuilder<TaskSnapshot?>(
                stream: imageUploader.imageUploadStream,
                builder: (BuildContext context,
                    AsyncSnapshot<TaskSnapshot?> asyncSnapshot) {
                  final selectedImage =
                      ref.read(imageUploadProvider).selectedImage;
                  if (asyncSnapshot.connectionState == ConnectionState.done) {
                    return ProgressBar(
                      imagePath: selectedImage!.name!,
                      progress: 1,
                    );
                  }

                  final taskSnapshot = asyncSnapshot.data;
                  if (taskSnapshot == null) {
                    return selectedImage != null
                        ? ProgressBar(imagePath: selectedImage.name!)
                        : Container();
                  }

                  double progress = 0;
                  switch (taskSnapshot.state) {
                    case TaskState.running:
                      progress = (taskSnapshot.bytesTransferred /
                          taskSnapshot.totalBytes);
                      break;
                    case TaskState.paused:
                      displaySnackbar(context, "Upload is paused.");
                      break;
                    case TaskState.canceled:
                      displaySnackbar(context, "Upload was canceled");
                      break;
                    case TaskState.error:
                      displaySnackbar(context,
                          "An error occurred and the upload has stopped");
                      break;
                    case TaskState.success:
                      progress = (taskSnapshot.bytesTransferred /
                          taskSnapshot.totalBytes);
                      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
                        if (uploadedImageUrl.isEmpty) {
                          updateImageUrl(imageUrl);
                          ref
                              .read(imageUploadProvider.notifier)
                              .updateIsImageUploading(false);
                        }
                      });
                  }
                  return ProgressBar(
                    imagePath: selectedImage!.name!,
                    progress: progress,
                  );
                }),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final String imagePath;
  final double progress;
  const ProgressBar({required this.imagePath, this.progress = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [Color(0xffa8dadc), Color.fromARGB(255, 241, 241, 241)],
          stops: [progress, progress],
        ),
        color: const Color(0xffa8dadc),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.photo,
              color: Color(0xffffffff),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                imagePath,
                style: const TextStyle(
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
