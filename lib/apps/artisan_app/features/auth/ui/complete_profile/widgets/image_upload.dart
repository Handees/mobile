import 'package:flutter/material.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff949494),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
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
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
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
          )
        ],
      ),
    );
  }
}
