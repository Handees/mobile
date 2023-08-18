import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handees/shared/utils/utils.dart';

class HandeeConcludedScreen extends StatefulWidget {
  const HandeeConcludedScreen({super.key});

  @override
  State<HandeeConcludedScreen> createState() => _HandeeConcludedScreenState();
}

class _HandeeConcludedScreenState extends State<HandeeConcludedScreen> {
  int count = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.clear),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 15,
              )
            ]),
            child: Stack(
              children: [
                Column(
                  children: [
                    HandeeInfoRow(
                      infoName: Text(
                        'Handee Fee',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      infoValue: Text(
                        '₦7,500',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    HandeeInfoRow(
                      infoName: Text(
                        'Time Spent',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      infoValue: Text(
                        '1 Hour, 3 Mins',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    HandeeInfoRow(
                      infoName: Text(
                        'Handee ID',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      infoValue: Text(
                        'KH9212924',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 4.25,
                  top: 15,
                  child: Column(
                    children: [
                      Dashes(
                        height: 70,
                        color: getHexColor('14161c'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Dashes(
                        height: 70,
                        color: getHexColor('14161c'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Please rate your customer',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: getHexColor('a4a1a1'),
                ),
          ),
          const SizedBox(
            height: 55,
          ),
          Stars(
              count: count,
              changeCount: (int newCount) {
                setState(() {
                  count = newCount;
                });
              }),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 16,
            ),
            width: double.infinity,
            child: FilledButton(
              child: const Text('Done'),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

class HandeeInfoRow extends StatelessWidget {
  final Widget infoName;
  final Widget infoValue;
  const HandeeInfoRow(
      {required this.infoName, required this.infoValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(999),
              ),
              color: Colors.black),
        ),
        const SizedBox(
          width: 10,
        ),
        infoName,
        const Spacer(),
        infoValue
      ],
    );
  }
}

class Dashes extends StatelessWidget {
  const Dashes({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashWidth = 1.0;
        const dashHeight = 3.0;
        final dashCount = (height / (2 * dashHeight)).ceil();
        return SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class Stars extends StatelessWidget {
  final int count;
  final void Function(int newCount) changeCount;
  const Stars({required this.count, required this.changeCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.63,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              int filled = count - 1;
              if (index <= filled) {
                return InkWell(
                  onTap: () {
                    changeCount(index + 1);
                  },
                  child: SvgPicture.asset('assets/svg/filled_star.svg'),
                );
              } else {
                return InkWell(
                  onTap: () {
                    changeCount(index + 1);
                  },
                  child: SvgPicture.asset('assets/svg/star.svg'),
                );
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: index < 5 ? 15 : 0,
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}

//TODO: Use the below to figure out how to get the zigzag of the receipt working
class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var smallLineLength = size.width / 20;
    const smallLineHeight = 20;
    var path = Path();

    path.lineTo(0, size.height);
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        path.lineTo(smallLineLength * i, size.height);
      } else {
        path.lineTo(smallLineLength * i, size.height - smallLineHeight);
      }
    }
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
