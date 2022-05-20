import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/screens/top_rated_screen.dart';

class TopRatedCard extends StatelessWidget {
  const TopRatedCard({
    Key? key,
  }) : super(key: key);

  final name = 'Gnomelander gardening services';
  final imagePath = 'assets/images/sample.png';
  final rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) {
        return TopRatedCardClosed(
          imagePath: imagePath,
          name: name,
          rating: rating,
        );
      },
      openBuilder: (context, action) {
        return TopRatedScreen();
      },
    );
  }
}

class TopRatedCardClosed extends StatelessWidget {
  const TopRatedCardClosed({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.rating,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: HandeeColors.shadowBlack, blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Container(
            //color: Colors.red,
            width: 170,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover),
            ),
            // child: FittedBox(
            //   child: Image.asset(name),
            // ),
          ),
          SizedBox(
            width: 170,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    height: 30,
                    child: Text(name),
                  ),
                  //SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(rating.toString()),
                          const Icon(
                            HandeeIcons.star_filled,
                            size: 12,
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
