import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final String text;
  final String secondText;
  final TextStyle style;
  const ListWidget(
      {super.key,
      required this.text,
      required this.secondText,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF14161C),
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                        color: Color(0xFF14161C),
                        fontSize: 14,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(secondText, style: style),
                )
              ],
            ),
          ],
        ));
  }
}

class DottedLines extends StatelessWidget {
  const DottedLines({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashWidth = 2.0;
        final dashHeight = height;
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(16, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
