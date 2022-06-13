import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:handee/utils/handee_colors.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key}) : super(key: key);

  final imagePath = 'assets/images/sample.png';
  final title = 'Ultra-Clean';
  final subtitle = 'Laundromat';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 170,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(color: HandeeColors.shadowBlack, blurRadius: 4),
          ],
          borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.bottomLeft,
      child: Container(
        alignment: Alignment.centerLeft,
        width: 105,
        height: 43,
        decoration: const BoxDecoration(
            color: HandeeColors.overlayBlue,
            borderRadius: BorderRadius.only(
              //bottomLeft: Radius.circular(5),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textScaleFactor: 0.9,
                style: const TextStyle(
                  color: HandeeColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                textScaleFactor: 0.75,
                style: const TextStyle(
                  color: HandeeColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
