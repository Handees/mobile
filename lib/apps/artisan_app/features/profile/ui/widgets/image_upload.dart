import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/services/storage_service.customer.dart';
import 'package:handees/shared/ui/widgets/custom_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends ConsumerStatefulWidget {
  const ImageUpload({super.key});

  @override
  ConsumerState<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends ConsumerState<ImageUpload> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String uploadedImageUrl = '';

  void displaySnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getImageUploadStream =
        ref.watch(storageServiceProvider).getImageUploadStream;
    Stream<TaskSnapshot?>? imageUploadStream;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              showModalBottomSheet(
                  context: context, builder: (BuildContext context) {
                    return CustomBottomSheet(title: 'Select Image Source', text: '', ctaText: ctaText, onPressCta: onPressCta)
                  });
              XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                imageUploadStream = ref
                    .watch(storageServiceProvider)
                    .getImageUploadStream(
                        file: File(image.path),
                        filename: image.name,
                        imageType: ImageType.validId);

                setState(() {
                  _selectedImage = File(image.path);
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: uploadedImageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(uploadedImageUrl),
                        fit: BoxFit.cover,
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
                  : const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            size: 50,
                            color: Color(0xffa8dadc),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "Upload your document here (PNG, JPG or PDF)",
                            style: TextStyle(
                              color: Color(0xff949494),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8.0),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "0 of 1 uploaded",
          //       style: TextStyle(
          //         color: Color(0xff949494),
          //       ),
          //     ),
          //     Text(
          //       "Cancel",
          //       style: TextStyle(
          //         color: Color(0xff949494),
          //       ),
          //     )
          //   ],
          // ),
          const SizedBox(height: 16.0),
          if (imageUploadStream != null)
            StreamBuilder<TaskSnapshot?>(
                stream: imageUploadStream,
                builder: (BuildContext context,
                    AsyncSnapshot<TaskSnapshot?> asyncSnapshot) {
                  final taskSnapshot = asyncSnapshot.data;
                  if (taskSnapshot == null) {
                    return _selectedImage != null
                        ? ProgressBar(imagePath: _selectedImage!.path)
                        : Container();
                  }
                  double progress = 0;
                  switch (taskSnapshot.state) {
                    case TaskState.running:
                      progress = 100 *
                          (taskSnapshot.bytesTransferred /
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
                      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
                        setState(() {
                          uploadedImageUrl = imageUrl;
                        });
                      });
                  }

                  return ProgressBar(
                    imagePath: _selectedImage!.path,
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
        color: const Color(0xffa8dadc),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.picture_as_pdf,
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
            const Icon(
              Icons.cancel_outlined,
              color: Color(0xffffffff),
            ),
          ],
        ),
      ),
    );
  }
}
