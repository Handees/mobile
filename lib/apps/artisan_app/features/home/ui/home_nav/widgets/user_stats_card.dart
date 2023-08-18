import 'package:flutter/material.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard(
    this.title,
    this.titleColor,
    this.backgroundColor, {
    super.key,
    this.onTap,
  });

  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: titleColor,
                ),
          ),
        ),
      ),
    );
  }
}
