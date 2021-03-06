import 'package:flutter/material.dart';
import 'package:handee/booking_status.dart';

import 'package:handee/utils/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/button.dart';
import 'package:handee/widgets/home_screen/booking.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/booking-details';

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final pDate = '2/12/2020';

  final pTime = '12:35';

  final textController = TextEditingController();
  final _ratingsKey = GlobalKey<_RatingsState>();

  bool ratingError = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //-80;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'Booking Details',
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 160,
                              child: Text(
                                'Gnomelander gardening service',
                                textScaleFactor: 1.3,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            BookingStatusWidget(
                                status: BookingStatus.completed),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                bullet(),
                                line(),
                                bullet(),
                                line(),
                                bullet(),
                                line(),
                                bullet(),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: SizedBox(
                                    height: 30,
                                    child: Text('Date booked : $pDate\n'
                                        'Time : $pTime'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 33,
                                ),
                                FittedBox(
                                  child: SizedBox(
                                    height: 30,
                                    child: Text('Date started : $pDate\n'
                                        'Time : $pTime'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 33,
                                ),
                                FittedBox(
                                  child: SizedBox(
                                    height: 30,
                                    child: Text('Date completed : $pDate\n'
                                        'Time : $pTime'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 33,
                                ),
                                const FittedBox(
                                  child: SizedBox(
                                    height: 30,
                                    child: Text('Adrress: '),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 0.75),
                    color: HandeeColors.grey161,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Rate your service',
                    textScaleFactor: 0.95,
                  ),
                  const SizedBox(height: 25),
                  if (ratingError)
                    const Text(
                      'Rating can\'t be empty',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  Ratings(
                    key: _ratingsKey,
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: HandeeColors.grey161),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: HandeeColors.grey161),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  HandeeButton(
                      text: 'Submit',
                      onTap: () {
                        submit().then((value) {
                          if (value == true) {
                            Navigator.of(context).pop();
                          }
                        });
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon bullet() {
    return const Icon(
      Icons.circle,
      size: 8,
      color: HandeeColors.grey161,
    );
  }

  Container line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      height: 51,
      width: 1,
      color: HandeeColors.grey161,
    );
  }

  Future<bool> submit() async {
    int rating = _ratingsKey.currentState?.rating ?? 0;
    if (rating == 0) {
      setState(() {
        ratingError = true;
      });
      return false;
    }
    return true;
  }
}

class Ratings extends StatefulWidget {
  const Ratings({
    Key? key,
    this.color = HandeeColors.black,
  }) : super(key: key);

  final Color color;

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < rating; ++i)
            GestureDetector(
              onTap: () {
                setState(() {
                  rating = i;
                });
              },
              child: Icon(
                HandeeIcons.star_filled,
                size: 33,
                color: widget.color,
              ),
            ),
          for (int i = 0; i < 5 - rating; ++i)
            GestureDetector(
              onTap: () {
                setState(() {
                  rating = i + rating + 1;
                });
              },
              child: Icon(
                HandeeIcons.star_outlined,
                size: 33,
                color: widget.color,
              ),
            ),
        ],
      ),
    );
  }
}
