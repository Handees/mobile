import 'package:flutter/material.dart';
import 'package:handees/ui/widgets/service_state.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({
    Key? key,
    required this.icon,
    required this.iconBackground,
  }) : super(key: key);

  final Color iconBackground;
  final Icon icon;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  var _test = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _test = !_test;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: _test ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              child: AnimatedContainer(
                height: _test ? 0 : 40.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('data'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.ac_unit),
                      label: const Text('Need help?'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
              child: Row(
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: widget.iconBackground.withOpacity(0.2),
                      shape: const CircleBorder(),
                    ),
                    height: 56,
                    width: 56,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: widget.iconBackground,
                        radius: 16,
                        child: widget.icon,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  const Expanded(
                    child: Text('Your handee man has arrived'),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ServiceStateWidget.canceled(),
                      Text(
                        '4th Jan 2022',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
