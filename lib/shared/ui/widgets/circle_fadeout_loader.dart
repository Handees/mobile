import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleFadeOutLoader extends StatefulWidget {
  const CircleFadeOutLoader({
    Key? key,
    this.color,
    this.count = 2,
    this.size = 200,
    this.duration = 1500,
  }) : super(key: key);

  final Color? color;
  final int count;
  final double size;
  final int duration;

  @override
  State<CircleFadeOutLoader> createState() => _CircleFadeOutLoaderState();
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
          duration: Duration(milliseconds: widget.duration),
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
              ),
              width: controller.value,
              height: controller.value,
            ),
          Material(
            elevation: 2.0,
            color: Colors.white,
            shape: const CircleBorder(),
            child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: SvgPicture.asset('assets/svg/logo-filled.svg')),
          ),
        ],
      ),
    );
  }
}
