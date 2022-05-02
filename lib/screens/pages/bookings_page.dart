import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/home_screen/booking.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical -
        kBottomNavigationBarHeight;
    //-80;
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              'Booking History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            pinned: true,
            centerTitle: true,
            backgroundColor: HandeeColors.white,
            shadowColor: Colors.black,
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
          // Container(
          //   width: double.infinity,
          //   height: 65,
          //   alignment: Alignment.bottomCenter,
          //   decoration: const BoxDecoration(
          //     color: HandeeColors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: HandeeColors.shadowBlack,
          //         blurRadius: 10,
          //       )
          //     ],
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: 25.0),
          //     child: Text(
          //       'Booking History',
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
