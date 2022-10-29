import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

class InProgressBottomSheet extends StatefulWidget {
  const InProgressBottomSheet({Key? key}) : super(key: key);

  @override
  State<InProgressBottomSheet> createState() => _InProgressBottomSheetState();
}

class _InProgressBottomSheetState extends State<InProgressBottomSheet>
    with TickerProviderStateMixin {
  bool get _expanded => _controller.status != AnimationStatus.completed;
  final _curve = Curves.linear;
  final _duration = const Duration(milliseconds: 200);
  final _reverseDuration = const Duration(milliseconds: 250);
  final time = 4;

  late final AnimationController _controller = AnimationController(
    duration: _duration,
    reverseDuration: _reverseDuration,
    vsync: this,
  );
  late final AnimationController _secondaryController = AnimationController(
    duration: _duration,
    reverseDuration: _reverseDuration,
    vsync: this,
    lowerBound: 0.2,
  );
  late final AnimationController _halfController = AnimationController(
    duration: _duration,
    reverseDuration: _reverseDuration,
    vsync: this,
    lowerBound: 0.5,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: _curve,
  );

  void _controllersFoward() {
    _controller.forward();
    _secondaryController.forward();
    _halfController.forward();
  }

  void _controllersReverse() {
    _controller.reverse();
    _secondaryController.reverse();
    _halfController.reverse();
  }

  void _controllersUpdate(double value) {
    _controller.value -= value;
    _secondaryController.value -= value * 0.8;
    _halfController.value -= value * 0.5;
  }

  @override
  void dispose() {
    _controller.dispose();
    _secondaryController.dispose();
    _halfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        print(details);

        // temporarilyIgnore();
        setState(() {
          _controllersUpdate(details.delta.dy / 250);
        });
      },
      onVerticalDragEnd: (_) {
        if (_controller.value > 0.5) {
          _controllersFoward();
        } else {
          _controllersReverse();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        _expanded
                            ? _controllersFoward()
                            : _controllersReverse();
                      },
                      icon: RotationTransition(
                        turns: CurvedAnimation(
                          parent: _halfController,
                          curve: _curve,
                        ),
                        child: const Icon(
                          Icons.expand_more,
                        ),
                      ),
                    ),
                    // child: Container(
                    //   width: 56,
                    //   height: 8,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(4),
                    //     color: Theme.of(context).colorScheme.primaryContainer,
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Your handee man is on the way!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: _secondaryController,
                  curve: _curve,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              shape: Shapes.smallShape,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Arrival time: $time mins',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    )),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const CircleAvatar(radius: 28),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jane Doe',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    color: Colors.red,
                                    height: 16,
                                    width: 96,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '17/24 handees completed',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                decoration: ShapeDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  shape: Shapes.mediumShape,
                                ),
                                height: 72,
                                width: 72,
                                child: const Center(
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: Icon(Icons.abc),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const SizedBox(
                                width: 64,
                                child: const Icon(Icons.money),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '₦500/hr',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FadeTransition(
                      opacity: ReverseAnimation(_animation),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ETA $time minutes'),
                          LinearProgressIndicator(
                            // value: 0.7,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _animation,
              child: Container(
                child: Divider(
                  height: 32.0,
                  thickness: 8.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  const Text(
                      'While you wait, you can reach out to them to confirm the  details of the service you need.'),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Call'),
                          style: Theme.of(context)
                              .extension<ButtonThemeExtensions>()
                              ?.filled,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        // width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print('why now');
                            Navigator.of(context)
                                .pushNamed(CustomerAppRoutes.chat);
                          },
                          child: const Text('Message'),
                          style: Theme.of(context)
                              .extension<ButtonThemeExtensions>()
                              ?.tonal,
                        ),
                      ),
                    ],
                  ),
                  SizeTransition(
                    sizeFactor: _animation,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.error,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
