import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnlineToggleCard extends StatelessWidget {
  const OnlineToggleCard(this.isOnline, this.setOnline, {super.key});

  final bool isOnline;
  final void Function() setOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/svg/handee_artisan_home_bg.svg",
            semanticsLabel: 'Handees Logo',
          ),
          const SizedBox(height: 16.0),
          isOnline
              ? SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: FilledButton(
                    onPressed: setOnline,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xffa8dadc),
                      ),
                    ),
                    child: const Text("YOU'RE ONLINE"),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: FilledButton(
                    onPressed: setOnline,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff14161c)),
                    ),
                    child: const Text('GO ONLINE'),
                  ),
                )
        ],
      ),
    );
  }
}
