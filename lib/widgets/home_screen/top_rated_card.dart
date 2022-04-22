import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/screens/top_rated_screen.dart';

class TopRatedCard extends StatelessWidget {
  const TopRatedCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  final name = 'Gnomelander gardening services';
  final imagePath = 'assets/images/sample.png';
  final rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //if (FocusManager.instance.primaryFocus != null) {
        FocusManager.instance.primaryFocus?.unfocus();
        Future.delayed(const Duration(milliseconds: 100)).then((value) =>
            Navigator.of(context).pushNamed(TopRatedScreen.routeName));
        // }else {
        //   Navigator.of(context).pushNamed(TopRatedScreen.routeName);
        // }
      },
      child: Container(
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
            Hero(
              tag: 'test', //Find suitable tag
              child: Container(
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
      ),
    );
  }
}
