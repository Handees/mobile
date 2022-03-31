import 'package:flutter/material.dart';

import 'package:handee/icons/handee_icons.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/button.dart';
import 'package:handee/widgets/top_rated_screen/booking_overlay.dart';

class TopRatedScreen extends StatelessWidget {
  TopRatedScreen({Key? key}) : super(key: key);

  static const routeName = '/top-rated';

  final name = 'Gnomelander gardening services';
  final cost = '10';
  final imagesPath = const [
    'assets/images/sample.png',
    'assets/images/sample.png',
    'assets/images/sample.png',
  ];
  final rating = 4.5;
  final description =
      'Gnomelander offers a wide range of services from lawn care to landscaping. '
      'You can never go wrong when you go green. '
      'Trust your homes to proffessionals like us.';

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final images = <Image>[];

    for (var imagePath in imagesPath) {
      images.add(Image.asset(imagePath));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Rated',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: HandeeColors.white,
        foregroundColor: HandeeColors.textDark,
        elevation: 0,
      ),
      backgroundColor: HandeeColors.white,
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImagePageView(images),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.bookmark_border),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 180,
                        child: Text(
                          name,
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    //Text('data'),
                    RichText(
                      text: TextSpan(
                        text: '\u20A6$cost',
                        style: const TextStyle(
                            color: HandeeColors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400),
                        children: const [
                          TextSpan(
                            text: ' / hr',
                            style: TextStyle(
                                color: HandeeColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 270,
                    child: Text(
                      description,
                      //textScaleFactor: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 55),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SizedBox(width: 10),
                      Row(
                        children: [
                          Text(
                            rating.toString(),
                            textScaleFactor: 1.5,
                          ),
                          const Icon(
                            HandeeIcons.star_filled,
                            size: 17,
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        color: HandeeColors.black,
                      ),
                      Row(
                        children: const [
                          Text(
                            '47',
                            textScaleFactor: 1.5,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Reviews',
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        color: HandeeColors.black,
                      ),
                      Row(
                        children: const [
                          Text(
                            '72',
                            textScaleFactor: 1.5,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Jobs\nCompleted',
                            textScaleFactor: 0.8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CircleAvatar(
                      backgroundColor: HandeeColors.transparent,
                      foregroundColor: HandeeColors.blue,
                      child: Icon(Icons.phone),
                      radius: 25,
                    ),
                    CircleAvatar(
                      backgroundColor: HandeeColors.transparent,
                      foregroundColor: HandeeColors.blue,
                      child: Icon(Icons.mail_outline),
                      radius: 25,
                    ),
                    CircleAvatar(
                      backgroundColor: HandeeColors.transparent,
                      foregroundColor: HandeeColors.blue,
                      child: Icon(Icons.location_on_outlined),
                      radius: 25,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                HandeeButton(
                  text: 'BOOK THIS SERVICE',
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: const BookingOverlay(),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePageView extends StatefulWidget {
  const ImagePageView(this.images, {Key? key}) : super(key: key);

  final List<Image> images;

  @override
  _ImagePageViewState createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  int _index = 0;

  final _tabControllers = <Widget>[];

  @override
  Widget build(BuildContext context) {
    _tabControllers.clear();
    for (int i = 0; i < widget.images.length; ++i) {
      if (i == _index) {
        _tabControllers.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              height: 6,
              width: 14,
              decoration: BoxDecoration(
                color: HandeeColors.black41,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        );
      } else {
        _tabControllers.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: HandeeColors.grey196,
            ),
          ),
        );
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Hero(
            tag: 'test', //Find suitable tag
            child: PageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              itemBuilder: (ctx, index) {
                return widget.images[index];
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _tabControllers,
        )
      ],
    );
  }
}
