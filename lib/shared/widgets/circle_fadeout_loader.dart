import 'package:flutter/material.dart';

class CircleFadeOutLoader extends StatefulWidget {
  const CircleFadeOutLoader({
    Key? key,
    this.color,
    this.count = 2,
    this.size = 200,
  }) : super(key: key);

  final Color? color;
  final int count;
  final double size;

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
          duration: const Duration(milliseconds: 1500),
          lowerBound: 0,
          upperBound: widget.size,
          value: widget.size * (i / count),
        )..repeat(reverse: false),
      );
    }

    controllers[0].addListener(() {
      setState(() {});
    });
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
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var controller in controllers)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(
                    (widget.size - controller.value) / widget.size),
                // border: Border.all(
                //   color: color.withOpacity(
                //       (widget.size - controller.value) / widget.size),
                // ),
              ),
              width: controller.value,
              height: controller.value,
            ),
          Material(
            elevation: 2.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            color: color,
            shape: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlutterLogo(
                size: widget.size / 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
