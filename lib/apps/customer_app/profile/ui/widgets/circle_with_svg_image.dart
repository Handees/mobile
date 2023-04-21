import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleAvatarWithSvgImage extends StatelessWidget {
  final String imagePath;

  const CircleAvatarWithSvgImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 235,
        height: 235,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xfff3f8fe),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            imagePath,
            height: 50,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
