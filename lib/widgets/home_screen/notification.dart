import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';

const style = TextStyle(color: Colors.black);

class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    Key? key,
    this.message,
    this.leading,
    this.color = Colors.transparent,
  }) : super(key: key);

  NotificationWidget.delivery({
    Key? key,
    required String agentName,
  }) : this(
          color: HandeeColors.lightBlue,
          leading: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              HandeeIcons.delivery_truck,
              color: HandeeColors.blue,
            ),
          ),
          message: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: agentName,
                  style: style.copyWith(color: HandeeColors.blue),
                ),
                const TextSpan(
                  text: ' are on their way to you!',
                ),
              ],
              // style: style,
            ),
          ),
        );

  NotificationWidget.schedule({
    Key? key,
    required String agentName,
  }) : this(
          key: key,
          color: HandeeColors.lightBlue,
          leading: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              HandeeIcons.clock,
              color: HandeeColors.blue,
            ),
          ),
          message: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Your schedule service with ',
                ),
                TextSpan(
                  text: agentName,
                  style: style.copyWith(color: HandeeColors.blue),
                ),
                const TextSpan(
                  text: ' is tomorrow',
                ),
              ],
            ),
          ),
        );

  NotificationWidget.welcome({Key? key})
      : this(
          leading: const CircleAvatar(
            backgroundColor: HandeeColors.grey237,
            foregroundColor: HandeeColors.black,
            child: Icon(HandeeIcons.codesandbox),
          ),
          message: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Welcome to ',
                ),
                TextSpan(
                  text: 'Handee',
                  style: style.copyWith(color: HandeeColors.blue),
                ),
                const TextSpan(
                  text: ' Barbara.',
                ),
              ],
            ),
          ),
        );

  final Widget? message;
  final Widget? leading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 85,
          width: double.infinity,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: message,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12, right: 25),
                  child: const Text(
                    'Time',
                  ),
                ),
              )
            ],
          ),
        ),
        if (color == HandeeColors.lightBlue) const SizedBox(height: 2),
        if (color != HandeeColors.lightBlue)
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                height: 0.5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 0.75),
                color: HandeeColors.grey161),
          ),
      ],
    );
  }
}
