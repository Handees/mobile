import 'package:flutter/material.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:handees/shared/res/shapes.dart';
import 'package:handees/shared/ui/widgets/service_state.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    Key? key,
    required this.jobCategory,
  }) : super(key: key);

  final JobCategory jobCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 80.0,
          child: Row(
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: jobCategory.foregroundColor.withOpacity(0.2),
                  shape: Shapes.mediumShape,
                ),
                height: 72,
                width: 72,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: jobCategory.foregroundColor,
                    child: Icon(jobCategory.icon),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  jobCategory.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const ServiceStateWidget.canceled(),
                  Text(
                    '4th Jan 2022',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
