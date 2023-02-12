import 'dart:math';

import 'package:flutter/material.dart';

class CircularLoader extends StatefulWidget {
  const CircularLoader(this.color, {super.key});

  final Color color;

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: pi * 2,
      duration: const Duration(milliseconds: 1500),
    )
      ..repeat(reverse: false)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _animationController.value,
      child: CustomPaint(
        size: Size(56, 56),
        painter: LinePainter(widget.color),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final rect = Rect.fromCircle(center: center, radius: radius);

    final gradient = SweepGradient(colors: [color, color.withOpacity(0.0)]);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect)
      // ..color = Colors.teal
      ..strokeWidth = 2;

    // canvas.drawArc(rect, 0, 3.147, true, paint);
    canvas.drawPath(
      Path()..addArc(rect, 0, pi * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
