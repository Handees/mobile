import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class HandeeStars extends StatelessWidget {
  final int count;
  final double height;
  final double width;
  const HandeeStars(
      {required this.count,
      required this.height,
      required this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              int filled = count - 1;
              if (index <= filled) {
                return SvgPicture.asset('assets/svg/small_gold_star.svg');
              } else {
                return SvgPicture.asset('assets/svg/small_empty_star.svg');
              }
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: index < 5 ? 5 : 0,
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
