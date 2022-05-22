import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/home_screen/booking.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Booking History',
            ),
            pinned: true,
            centerTitle: true,
            // toolbarHeight: 60,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return const BookingWidget();
                // return Notification();
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
