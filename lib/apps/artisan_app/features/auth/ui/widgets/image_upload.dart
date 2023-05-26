import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/services/storage_service.customer.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends ConsumerStatefulWidget {
  const ImageUpload({super.key});

  @override
  ConsumerState<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends ConsumerState<ImageUpload> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final uploadImage = ref.watch(storageServiceProvider).uploadImage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                String url = await uploadImage(
                    file: File(image.path),
                    filename: image.name,
                    imageType: ImageType.validId);
                debugPrint(url);
                debugPrint(image.path);
                debugPrint(image.name);

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
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(_selectedImage!),
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
              child: _selectedImage != null
                  ? null
                  : Center(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0 of 1 uploaded",
                style: TextStyle(
                  color: Color(0xff949494),
                ),
              ),
              Text(
                "Cancel",
                style: TextStyle(
                  color: Color(0xff949494),
                ),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffa8dadc),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    color: Color(0xffffffff),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "lorem ipsum.pdf",
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.cancel_outlined,
                    color: Color(0xffffffff),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
