import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.icon,
    required this.iconBackground,
    required this.artisanCount,
  }) : super(key: key);

  final String serviceName;
  final Widget icon;
  final Color iconBackground;
  final int artisanCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 96,
      width: double.infinity,
      child: Row(
        children: [
          Ink(
            decoration: ShapeDecoration(
              color: iconBackground.withOpacity(0.2),
              shape: Shapes.smallShape,
            ),
            height: 72,
            width: 72,
            child: Center(
              child: CircleAvatar(
                backgroundColor: iconBackground,
                child: icon,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Laundry',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '$artisanCount Handeemen near you',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
