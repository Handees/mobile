import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handees/apps/artisan_app/features/home/providers/artisan-location.provider.dart';
import 'package:handees/apps/artisan_app/services/sockets/artisan_socket.dart';
import 'package:handees/shared/ui/widgets/custom_bottom_sheet.dart';

class OnlineToggleCard extends ConsumerStatefulWidget {
  const OnlineToggleCard({super.key});

  @override
  ConsumerState<OnlineToggleCard> createState() => _OnlineToggleCardState();
}

class _OnlineToggleCardState extends ConsumerState<OnlineToggleCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    ref.read(locationProvider.notifier).initLocation();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArtisanOnline = ref.watch(artisanOnlineProvider);

    return Column(
      children: [
        SvgPicture.asset(
          "assets/svg/handee_artisan_home_bg.svg",
          semanticsLabel: 'Handees Logo',
        ),
        const SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xffa8dadc), Color(0xff14161c)],
              stops: [animation.value, animation.value],
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: isArtisanOnline
              ? FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (sheetCtx) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
                            ),
                            child: CTABottomSheet(
                              title: 'Go Offline',
                              text: "Are you sure you want to go offline?",
                              ctaText: "Go Offline",
                              onPressCta: () async {
                                ref.read(artisanOnlineProvider.notifier).state =
                                    false;
                                ref
                                    .read(artisanSocketProvider.notifier)
                                    .disconnectArtisan();
                                controller.reset();
                                Navigator.pop(context);
                              },
                            ),
                          );
                        });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffa8dadc)),
                  ),
                  child: const Text("YOU'RE ONLINE"))
              : GestureDetector(
                  onTapDown: (details) {
                    controller.forward();
                  },
                  onTapCancel: () {
                    if (animation.value != 1) {
                      controller.reverse();
                    } else {
                      ref.read(artisanOnlineProvider.notifier).state = true;
                      ref.read(artisanSocketProvider.notifier).connectArtisan();
                    }
                  },
                  child: FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text('GO ONLINE'),
                  ),
                ),
        )
      ],
    );
  }
}
