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
    return
      SafeArea(child:
      Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: _height,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return BookingWidget();
                  // return Notification();
                },
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 65,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: HandeeColors.white,
              boxShadow: [
                BoxShadow(
                  color: HandeeColors.shadowBlack,
                  blurRadius: 10,
                )
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Text(
                'Booking History',
                textScaleFactor: 1.1,
                style: TextStyle(
                    color: HandeeColors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
