import 'package:flutter/material.dart';

class CircleFadeOutLoader extends StatefulWidget {
  const CircleFadeOutLoader({
    Key? key,
    this.color = Colors.black,
    this.count = 3,
    this.size = 100,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  final Color color;
  final int count;
  final double size;
  final Duration duration;

  @override
  _CircleFadeOutLoaderState createState() => _CircleFadeOutLoaderState();
}

class _CircleFadeOutLoaderState extends State<CircleFadeOutLoader>
    with TickerProviderStateMixin {
  final controllers = <AnimationController>[];

  @override
  void initState() {
    super.initState();
    final count = widget.count;
    for (int i = 0; i < count; ++i) {
      controllers.add(
        AnimationController(
          vsync: this,
          duration: widget.duration,
          lowerBound: 0,
          upperBound: widget.size,
          value: widget.size * (i / count),
        ),
      );
    }

    controllers[0].addListener(() {
      setState(() {});
    });
    for (var controller in controllers) {
      controller.repeat(reverse: false);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var controller in controllers)
            Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.color.withOpacity(
                      (widget.size - controller.value) / widget.size),
                ),
              ),
              width: controller.value,
              height: controller.value,
            ),
        ],
      ),
    );
  }
}
