import 'package:flutter/material.dart';
import 'package:handee/booking_status.dart';
import 'package:handee/utils/handee_colors.dart';
import 'package:handee/screens/booking_details.dart';

class BookingWidget extends StatelessWidget {
  const BookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(BookingDetailsScreen.routeName);
      },
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          children: [
            Container(
              height: 85,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gnomelander gardening services',
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        const Text('4th Jan 2022'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      BookingStatusWidget(status: BookingStatus.confirmed),
                      SizedBox(height: 10),
                      Text('4th Jan 2022'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 0.75),
              color: HandeeColors.grey161,
            ),
          ],
        ),
      ),
    );
  }
}

class BookingStatusWidget extends StatelessWidget {
  const BookingStatusWidget({Key? key, required this.status}) : super(key: key);

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String text;

    switch (status) {
      case BookingStatus.confirmed:
        color = HandeeColors.blue;
        text = 'Confirmed';
        break;
      case BookingStatus.ongoing:
        color = HandeeColors.green;
        text = 'Ongoing';
        break;
      case BookingStatus.completed:
        color = HandeeColors.black22;
        text = 'Completed';
        break;
      case BookingStatus.cancelled:
        color = HandeeColors.grey196;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: HandeeColors.white,
            ),
      ),
    );
  }
}
