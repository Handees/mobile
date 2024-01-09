import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/features/review/ui/widgets/review_screen_widgets.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int rating = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/review_screen/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, bottom: 25),
                  child: Icon(
                    Icons.close_outlined,
                    size: 32.0,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const ListWidget(
                  text: 'Service fee',
                  secondText: '₦7,500',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: 0.36,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 28.0),
                  child: SizedBox(
                    height: 42,
                    child: DottedLines(),
                  ),
                ),
                const ListWidget(
                  text: 'Time Spent',
                  secondText: '1hr3mins',
                  style: TextStyle(
                    color: Color(0xFF14161C),
                    fontSize: 14,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 28.0),
                  child: SizedBox(
                    height: 42,
                    child: DottedLines(),
                  ),
                ),
                const ListWidget(
                  text: 'Service ID',
                  secondText: 'KH9212924',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 200,
                  child: Center(
                      child: Text(
                    'Please rate your customer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFA4A0A0),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                      letterSpacing: 0.32,
                    ),
                  )),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FivePointedStar(
                        size: const Size(42, 42),
                        selectedColor: Colors.black,
                        onChange: (count) {
                          setState(() {
                            rating = count;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            width: 366.0,
            height: 72.0,
            margin: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: Color(0xFF14161C),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
          ),
        ),
      ),
    );
  }
}
