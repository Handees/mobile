import 'package:flutter/material.dart';
import 'package:handee/booking_status.dart';
import 'package:handee/handee_colors.dart';
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
              color: HandeeColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Gnomelander gardening service',
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text('4th Jan 2022'),
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
      alignment: Alignment.center,
      width: 60,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        textScaleFactor: 0.8,
        style: const TextStyle(color: HandeeColors.white),
      ),
    );
  }
}
